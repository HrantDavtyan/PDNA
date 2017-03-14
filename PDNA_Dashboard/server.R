library("RMySQL")

mydb <<- NULL

loadData <- function() {
  if (exists("responses")) {
    database
    
  }
}

function(input,output,session) {
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })
  
  # collabse disaster_event_box once Next (submit_event) button is clicked
  observeEvent(input$submit_event, {
    js$collapse("disaster_event_box")
  })
  
  # collabse new_entry_box once Next (submit_entry) button is clicked
  observeEvent(input$submit_entry, {
    js$collapse("new_entry_box")
  })
  
  # change the title of disaster event box
  output$box_title <- renderText({
    if(input$disaster=="" || input$marz=="")
      "Create a Disaster Event"
    else
      paste(input$disaster,input$marz,input$date[1],sep="  ")
  })
  
  # function for making connection to DB
  connect_to_db<-function(){
    
    if(is.null(mydb)){
      all_cons <- dbListConnections(MySQL())
      for(con in all_cons)
        dbDisconnect(con)
      
      mydb <<- dbConnect(MySQL(), user='sql11163581',password='hqQPqpXiLd',dbname='sql11163581', host='sql11.freemysqlhosting.net')
      
      
    }
    return (mydb)
  }
  
  # function for refreshing output table (loading and showing data)
  refresh_table <- function(effecto){
    mydb = connect_to_db()
    print("a")
    rs = dbSendQuery(mydb, paste0("select * from ",effecto))
    rs = fetch(rs, n=-1)
    responses <<- rs
    responses["name"] <<- ""
    responses["community"] <<- ""
    responses["disaster"] <<- ""
    len <<- length(responses)
    for (i in c(1:length(responses[,1]))){
      query <- paste0("select name from fermers where ID='",responses[i,2],"';", sep = "")
      rs <- dbGetQuery(mydb, query)
      responses[i,len-2]<<-rs[,1]
      query <- paste0("select name from community where ID='",responses[i,4],"';", sep = "")
      rs <- dbGetQuery(mydb, query)
      responses[i,len-1]<<-rs[,1]
      query <- paste0("select Disaster_ID from disaster_event where ID='",responses[i,5],"';", sep = "")
      rs <- dbGetQuery(mydb, query)
      query <- paste0("select name from disaster where ID='",rs[,1],"';", sep = "")
      rs <- dbGetQuery(mydb, query)
      responses[i,len]<<-rs[,1]
      
    }
    if(exists("database")){
      database <<- rbind(cbind(responses[nrow(responses),c(len-2,len-1,len)],responses[nrow(responses),c("damages","loss")]),database)
    }
    else{
      database <<- rbind(cbind(responses[nrow(responses),c(len-2,len-1,len)],responses[nrow(responses),c("damages","loss")]))
    }
  }
  
  # get the general (not effect level) data from DB
  check_overall <- function(){
    
    mydb = connect_to_db()
    
    marz_name = formData()$marz
    rs = dbSendQuery(mydb, "select * from marz")
    rs = fetch(rs, n=-1)
    marz_id = as.matrix(rs["ID"])[which(rs["name"] == marz_name)]
    date = formData()$date
    disaster_name = formData()$disaster
    rs = dbSendQuery(mydb, "select * from disaster")
    rs = fetch(rs, n=-1)
    disaster_id = as.matrix(rs["ID"])[which(rs["name"] == disaster_name)]
    desc = formData()$description
    date_start = date[1]
    date_end = date[2]
    query <- paste0("INSERT INTO disaster_event (Date_start, Date_end,Marz_ID,Disaster_ID,Description) 
                    VALUES('",date_start,"','",date_end,"',", marz_id,",",disaster_id,",'", desc,"')")
    rs = dbSendQuery(mydb, "select * from disaster_event")
    rs = fetch(rs, n=-1)
    if(!length(which(rs["Marz_ID"] == marz_id & rs["Disaster_ID"] == disaster_id & rs["Description"] == desc))){
      dbGetQuery(mydb, query)
    }
    rs = dbSendQuery(mydb, "select * from disaster_event")
    rs = fetch(rs, n=-1)
    dis_ev_id = as.matrix(rs["ID"])[which( rs["Marz_ID"] == marz_id & rs["Disaster_ID"] == disaster_id & rs["Description"] == desc)]
    
    
    com_name = formData()$community
    rs = dbSendQuery(mydb, "select * from community")
    rs = fetch(rs, n=-1)
    com_id = as.matrix(rs["ID"])[which(rs["name"] == com_name)]
    name = formData()$name
    rs = dbSendQuery(mydb, "select * from fermers")
    rs = fetch(rs, n=-1)
    
    if(!length(which(rs["name"] == name))){
      query <- paste0("INSERT INTO fermers (name) VALUES('",name,"')")
      dbGetQuery(mydb, query)
    }
    rs = dbSendQuery(mydb, "select * from fermers")
    rs = fetch(rs, n=-1)
    ferm_id = as.matrix(rs["ID"])[which(rs["name"] == name)]
    retList <- list("mydb" = mydb, "marz_id" = marz_id,"date_start" = date_start,"date_end"=date_end,
                    "disaster_id" = disaster_id,"desc" = desc,"dis_ev_id" = dis_ev_id,"com_id" =com_id,"ferm_id" = ferm_id)
    return(retList)
    
  }
 
  # script for defaults
  source("annual_default.R",local=TRUE)
  source("tree_default.R",local=TRUE)
  source("livestock_default.R",local=TRUE)
  source("land_default.R",local=TRUE)
  source("assets_default.R",local=TRUE)
  
  # script for customs
  source("annual_custom.R",local=TRUE)
  source("tree_custom.R",local=TRUE)
  source("livestock_custom.R",local=TRUE)
  
  # designing the DataTable to show the Damage/Loss sum
  sketch = htmltools::withTags(table(
    tableHeader(c("N","Name","Community","Disaster","Damage","Loss")),
    tableFooter(c("","","","",0,0))
  ))
  
  # continuing desining: copied from JavaScript lib
  opts <- list(dom = 'Bfrtip', buttons = list('colvis','print',list(extend='collection',text='Download',
                                              buttons = list('copy','csv','excel','pdf'))), 
    footerCallback = JS(
      "function( tfoot, data, start, end, display ) {",
      "var api = this.api();",
      "$( api.column( 5 ).footer() ).html('AMD  '+",
      "api.column( 5).data().reduce( function ( a, b ) {",
      "return a + b;",
      "} )",
      ");",
      "$( api.column( 4 ).footer() ).html('AMD '+",
      "api.column( 4 ).data().reduce( function ( a, b ) {",
      "return a + b;",
      "} )",
      ");",
      "}")
  )
  
  # Show the previous responses (update with current response when default is clicked)
  output$table <- DT::renderDataTable(filter = 'top', container = sketch,extensions = 'Buttons',options = opts,{
    input$default || input$default_tree || input$default_land
    loadData()
  })
  # toggle Modal windows after submission to show confirmation page
  observeEvent(input$custom_crop,{
  toggleModal(session,"custom_inputs_crop", toggle = "close")
  })
  observeEvent(input$custom_tree,{
    toggleModal(session,"custom_inputs_tree", toggle = "close")
  })
  observeEvent(input$custom_livestock,{
    toggleModal(session,"custom_inputs_livestock", toggle = "close")
  })
}
