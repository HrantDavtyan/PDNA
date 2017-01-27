# Autocomplete can be also done by using shinysky as below
# However, seletizeInput is easier and more beautiful
# library(shinysky)
#   textInput.typeahead(id = "Crop name",valueKey = "crop",
#     placeholder = "Please enter crop name",
#     local = data.frame(crop=c(crop_list)),
#     tokens = c(1:length(crop_list)),
#     template = HTML("<p class='repo-language'>{{info}}</p> <p class='repo-name'>{{crop}}</p>")),

# create save and load functions

saveData <- function(data) {
  data <- as.data.frame(cbind(t(data),Damages=7))
  if (exists("responses")) {
    responses <<- rbind(responses, data)
  } else {
    responses <<- data
  }
}


loadData <- function() {
  if (exists("responses")) {
    # play with the next row to show damages and losses
    responses
  }
}

# define list of crops
crop_list <- sort(c("","Potato","Melon","Other"))
function(input, output) {
  
  output$ui <- renderUI({
    if (is.null(input$affect))
      return()
    
    # Depending on input$affect, we'll generate a different
    # UI component and send it to the client.
    switch(input$affect,
           
           "Annual crops" = fluidRow(
                                    column(3,
                                           wellPanel(
                                             selectizeInput("crop", "Crop name",choices = crop_list,
                                                            options = list(create = TRUE)),
                                             selectInput("unit","Measurement Unit",
                                                         choices = list("M2","Ha"), selected = NULL)
                                           )),
                                    column(3,
                                           wellPanel(numericInput("lost", "Units lost", min = 0, value = 1),
                                                     numericInput("veg", "Vegetation", min = 0, value = 0)
                                                     )),
                                    column(3,
                                           wellPanel(numericInput("reduced","Units with Reduced Yield", 
                                                        min = 0, value = 0),
                                                     sliderInput("reduction","Share of Reduction",
                                                                 min = 0, max = 100, value = 75)
                                           )),
                                    column(3,
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           actionButton("submit","Submit",width = "30%")
                                           )),
           "Trees and Bushes" = fluidRow(
                                    column(3,
                                           wellPanel(numericInput("a", "A", value =5))),
                                    column(3,
                                           wellPanel(numericInput("a", "A", value =5))
                                           )),
           "Livestock" = fluidRow(
                                    column(3,
                                           wellPanel(numericInput("a", "A", value = 5))
                                           ))
    )
  })
  
  # Whenever a field is filled, aggregate all form data
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })
  
  # When the Submit button is clicked, save the form data
  observeEvent(input$submit, {
    saveData(formData())
  })
  
  # Show the previous responses
  # (update with current response when Submit is clicked)
  output$responses <- DT::renderDataTable(filter = 'top',{
    input$submit
    loadData()
  })
  
  # Plot histogram in Visuals tab of Reports menu

  output$plot <- renderPlot({
    hist(xlab = input$baroptions, main = paste("Hist of", input$baroptions),
         as.numeric(as.character(responses[[input$baroptions]])))
  })
  
  # output$damloss <- DT::renderDataTable({
  #   a<-as.numeric(as.character(responses$reduced))
  #   b<-as.character(responses$community)
  #   data <-cbind(a,b)
  #   damloss <- as.data.frame(data)
  # })
}
