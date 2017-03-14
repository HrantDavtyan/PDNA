body <- dashboardBody(tabItems(
  tabItem(tabName = "dashboard",
          fluidRow(infoBoxOutput("total_damage_box"),column(4,""),infoBoxOutput("total_loss_box")       
          ),
          fluidRow(
            # column(width = 3,
            #        box(title = "Filters", width = NULL, background = "light-blue",
            #            selectizeInput("marz",label="Marz",choices=marz_list,multiple = TRUE,selected=NULL),
            #            selectizeInput("community",label="Community",choices=community_list,multiple = TRUE,selected=NULL),
            #            selectizeInput("disaster",label="Disaster type",choices=disaster_list,multiple=TRUE,selected=NULL),
            #            selectizeInput("affect", label ="Disaster effect", multiple = TRUE,selected = NULL,
            #                           choices = list("","Annual crops", "Trees and Bushes","Livestock"))
            #            )),
            column(width = 12,
                   #box(title = "Plot", width = NULL, solidHeader = TRUE, status = "primary",
                       leafletOutput("mymap"))#)
                   )
  ),
  tabItem(tabName = "review",
          fluidRow(column(2,actionButton("download_crop","Download Crops",icon("download"))),
                   column(2,actionButton("download_tree","Download Trees",icon("download"))),
                   column(2,actionButton("download_livestock","Download Livestock",icon("download"))),
                   column(2,actionButton("download_asset","Download Asssets",icon("download"))),
                   column(2,actionButton("download_land","Download Lands",icon("download"))),
                   column(2,actionButton("edit_data","Edit Data",icon("edit")))),
          br(),
          flowLayout(selectizeInput("select_effect","Select effect to review",
                                    choices=c("","an_cr_entry","tree_entry","land_entry",
                                              "asset_entry","livestock_entry"))),
          fluidRow(
            column(12,
                   conditionalPanel(condition="input.select_effect!=''",
                   dataTableOutput("table"))),
            bsModal("edit_table_modal","Edit data","edit_data",size = "large",footer=NULL,
                    htable("edit_table",colHeaders="provided"),
                    actionButton("submit_edit_table","Submit modifications")),
            bsModal("confirmation","Success!", "submit_edit_table",size="small",
                    helpText("Your changes have been saved to database"))
          )
  ),
  tabItem(tabName = "defaults",
          wellPanel(style = "background-color: #ffffff;",fluidRow(column(6,
              selectizeInput("default_marz",label="Marz",choices=marz_list,selected=NULL)),
              column(6,
              selectizeInput("default_affect", label ="Disaster effects", selected = NULL,
                                choices = affect_list))
              )),
          fluidRow(
            column(4,source("default_trees.R",local=TRUE)[1]),
            column(4,source("default_annual.R",local=TRUE)[1]),
            column(4,source("default_livestock.R",local=TRUE)[1])),
          fluidRow(column(4,offset = 4,
                          actionButton("update_defaults","Update",width = "100%"))),
          bsModal("def_update_confirmation","Success !","update_defaults",size="small",
            helpText("Default values have been updated")
          )
  ),
  tabItem(tabName = "test",
          tags$iframe(id = "googleform",
                      src = 'https://docs.google.com/spreadsheets/d/1YxO4SEor1cDYcA2nBl-zFzNEkfD3TiWOYJ3a8rpxQ6E/pubhtml?gid=0&amp;single=true&amp;widget=true&amp;headers=false',
                      width = "100%",
                      height = 1000,
                      frameborder = 0,
                      marginheight = 0)
  ),
  tabItem(tabName = "help",
          fluidRow(leafletOutput("contacts_map")#,
                   # absolutePanel(id = "absolute",  fixed = TRUE,
                   #               draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                   #               width = 330, height = "auto",
                   #               
                   #               h2("Filters"),
                   #               selectizeInput("marz",label="Marz",choices=marz_list,multiple = TRUE,selected=NULL),
                   #               selectizeInput("community",label="Community",choices=community_list,multiple = TRUE,selected=NULL),
                   #               selectizeInput("disaster",label="Disaster type",choices=disaster_list,multiple=TRUE,selected=NULL),
                   #               selectizeInput("affect", label ="Disaster effect", multiple = TRUE,selected = NULL,
                   #                              choices = list("","Annual crops", "Trees and Bushes","Livestock"))
                   #               )
                                 )
  )
)
)
