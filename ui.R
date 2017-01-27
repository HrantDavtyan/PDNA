library(shinydashboard)

header <- dashboardHeader(title = "PDNA Dashboard",
                          dropdownMenu(type = "messages",messageItem(from = "Ministry",
                                  message = "No compensastion this time!"),
                                    messageItem(from = "Community",
                                      message = "How do I input?",icon = icon("question"),time = "13:45"),
                                    messageItem(from = "Support",
                                      message = "The PDNA app is ready.",icon = icon("life-ring"),time = "2014-12-01")
                          ),
                          dropdownMenu(type = "notifications",notificationItem(text = "5 new users today",
                                         icon("users")),
                                       notificationItem(text = "12k seeds delivered",
                                         icon("truck"),status = "success"),
                                       notificationItem(text = "Damage of 86%",
                                         icon = icon("exclamation-triangle"),status = "warning")
                          ),
                          dropdownMenu(type = "tasks", badgeStatus = "success",
                                       taskItem(value = 90, color = "green","Documentation"),
                                       taskItem(value = 17, color = "aqua","Project X"),
                                       taskItem(value = 75, color = "yellow","Server deployment"),
                                       taskItem(value = 80, color = "red","Overall project")
                          )
                          )

sidebar <- dashboardSidebar(
    sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                      label = "Search..."),
    sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Report", icon = icon("th"), tabName = "report",
             badgeLabel = "new", badgeColor = "green"))
    )

body <- dashboardBody(tabItems(
  tabItem(tabName = "dashboard",
    fluidRow(
      box(
        title = "Create a Disaster Event", solidHeader = TRUE, width = 4, status = "primary", collapsible = TRUE,
          dateRangeInput("date", "Date input", start = NULL, end=NULL),
          selectizeInput("marz",label="Marz",choices=list("","Shirak","Armavir","Ararat"),selected=NULL),
          selectizeInput("disaster", label = "Disaster",choices = list("","Hail", "Frost","Drought"), selected = 1),
          textAreaInput("description",label = "Description",height = '150px')
        
      ),
      box(collapsible = TRUE,
          title = "Make a new entry", width = 4, solidHeader = TRUE, status = "warning",
          textInput("name", label = "Name",placeholder = "Please enter farmer's full name"),
          selectInput("affect", label ="Disaster effects", multiple = TRUE,
                      choices = list("","Annual crops", "Trees and Bushes","Livestock"), selected = NULL),
          selectizeInput("community",label="Community",choices=list("","Qarakert","Dalarik","Other"),selected=NULL)
      )
      
    ),
    
    fluidRow(
             tabBox( 
               width = 8, title = "Input data",
               tabPanel("Annual crops",
               selectizeInput("crop", "Crop name",choices = crop_list,
                              options = list(create = TRUE,
                                             placeholder = "Which crop was affected?")),
               conditionalPanel(condition ="input.crop!=''",
                                selectInput("unit","Measurement Unit",
                                            choices = list("Ha","M2")),
                                numericInput("lost", "Units lost", min = 0, value = 0),
                                # radioButtons("replanting","Replanting possible",
                                #              choices = c("Yes","No"), inline=TRUE),
                                fluidRow(column(6,numericInput("reduced","Units with Reduced Yield",
                                                               min = 0, value = 0)),
                                         conditionalPanel(condition ="input.reduced >0",
                                                          column(6, sliderInput("reduction","Share of Reduction",
                                                                                min = 0, step = 5, max = 100, value = 75)))),
                                fluidRow(column(2,actionButton("default","Use Defaults",
                                                               style = "background-color: #337ab7; border-color: #2e6da4")),
                                         column(2,actionButton("custom","Create Custom",
                                                               style = "background-color: orange; border-color: orange")))
               )),
               tabPanel("Trees and Bushes"),
               tabPanel("Livestock")
             )
          )
      ),
  tabItem(tabName = "report",
    dataTableOutput("table")
    )
 )
)

dashboardPage(header, sidebar, body)