library(shiny)
library(DT)
# can download bootstrap.cs into www directory and call it in navbarPage to change the UI style
# using the tag code below
# tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"))
# however, shinythemes provides a large and better accessible library

library(shinythemes)


navbarPage(theme = shinythemes::shinytheme("flatly"), "Version_3",
           tabPanel("Community",
                    em("Create disaster event",
                       style = "font-family: 'times'; font-size: 16pt; color: green"),
                    # call fluidrow() for row ranked items
                    wellPanel(fluidRow(
                      
                      column(3, 
                             dateInput("date", 
                                       label = h3("Date input"), 
                                       value = NULL)),   
                      column(3,
                             tags$style(".selectize-input {line-height: 30px;}"),
                             selectizeInput("community", label = h3("Community"), 
                                         choices = list("","Qarakert", "Dalarik",
                                                        "Other"), selected = NULL)),
                      column(3,
                             selectizeInput("disaster", label = h3("Disaster"), 
                                         choices = list("","Hail", "Frost",
                                                        "Drought"), selected = 1)),
                      column(3, offset = 0,
                             br(),
                             br(),
                             br(),
                             actionButton("next", "Next", width = "50%"
                                          # icon("plus"),
                                          # style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
                                          
                             )
                             
                      )
                    )
                    ),
                    conditionalPanel(condition = "input.next %2 == 1 && input.community != '' &&
                                     input.disaster != '' ",
                                     em("Select farmer",
                                        style = "font-family: 'times'; font-size: 16pt; color: green"),
                                     fluidRow(
                                              column(3, wellPanel(
                                                    textInput("name", label = h3("Full Name"), 
                                                            placeholder = "Please enter farmer's full name"))),
                                              column(3, wellPanel(
                                                     selectInput("affect", label =h3("Impact type"),
                                                       choices = list("","Annual crops", "Trees and Bushes",
                                                                      "Livestock"), selected = NULL
                                                     )))
                                     ),
                                       # This outputs the dynamic UI component
                                       uiOutput("ui")
                    )
                    ),
           tabPanel("Marz",
                    navlistPanel(widths = c(2,9),
                                 "Part 2 - Marz",
                                 tabPanel("Annual Crops",
                                          tabsetPanel("",
                                                     tabPanel("Input data",
                                                              em("General input",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4, 
                                                                       textInput("text", label = h3("Crop type"), 
                                                                                 placeholder = "Please enter the crop name", width = "85%")),
                                                                column(4,
                                                                       selectInput("select", label = h3("Measurement Unit"), 
                                                                                   choices = list("ha", "units"), selected = 1, width = "85%"))          
                                                              ),
                                                              br(),
                                                              em("Yield",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4,
                                                                       numericInput("number", label = h3("Standard yearly income yield / unit"),
                                                                                    min = 0, value = 0,  width = "85%")),
                                                                column(4,
                                                                       numericInput("number", label = h3("Replanted income yield / unit"),
                                                                                    min = 0, value = 0,  width = "85%"))            
                                                              ),
                                                              br(),
                                                              em("Cost",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4,
                                                                       numericInput("number", label = h3("Replanting cost / unit"),
                                                                                    min = 0, value = 0,  width = "85%")),
                                                                column(4,
                                                                       numericInput("number", label = h3("Recovery cost / unit"),
                                                                                    min = 0, value = 0,  width = "85%"))           
                                                              )
                                                              # column(3, offset = 7,
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        submitButton("Submit",width = "30%"))
                                                     ),
                                                     tabPanel("Calculator",
                                                              em("Yield",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(3, 
                                                                       numericInput("number", label = h3("Units"), 
                                                                                    min = 0, value = 1)),
                                                                column(3, 
                                                                       numericInput("number", label = h3("Yield (AMD)"), 
                                                                                    min = 0, value = 1000))
                                                              ),
                                                              em("Cost",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(3, 
                                                                       numericInput("number", label = h3("Units"), 
                                                                                    min = 0, value = 1)),
                                                                column(3, 
                                                                       numericInput("number", label = h3("Cost (AMD)"), 
                                                                                    min = 0, value = 1000))
                                                              )
                                                     ),
                                                     tabPanel("Help",
                                                              
                                                              column(3, 
                                                                     h3("Help text"),
                                                                     helpText("You can get help from this page,", 
                                                                              "it provides an easy way to add text to",
                                                                              "accompany other widgets.",style = "color: grey"))
                                                     )
                                          )),
                                 tabPanel("Trees and Bushes",
                                          tabsetPanel("",
                                                     tabPanel("Input data",
                                                              em("General input",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4, 
                                                                       textInput("text", label = h3("Crop type"), 
                                                                                 placeholder = "Please enter the crop name", width = "85%")),
                                                                column(4,
                                                                       selectInput("select", label = h3("Measurement Unit"), 
                                                                                   choices = list("ha", "units"), selected = 1, width = "85%"))          
                                                              ),
                                                              br(),
                                                              em("Yield",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4,
                                                                       numericInput("number", label = h3("Standard yearly income yield / unit"),
                                                                                    min = 0, value = 0,  width = "85%"))
                                                              ),
                                                              br(),
                                                              em("Cost",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4,
                                                                       numericInput("number", label = h3("Replanting cost / unit"),
                                                                                    min = 0, value = 0,  width = "85%")), 
                                                                column(4,
                                                                       numericInput("number", label = h3("Maitanance cost / unit"),
                                                                                    min = 0, value = 0,  width = "85%")),
                                                                column(4,
                                                                       numericInput("number", label = h3("Recovery cost / unit"),
                                                                                    min = 0, value = 0,  width = "85%"))           
                                                              )
                                                              # column(3, offset = 7,
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        submitButton("Submit",width = "30%"))
                                                     ),
                                                     tabPanel("Calculator",
                                                              em("Yield",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(3, 
                                                                       numericInput("number", label = h3("Units"), 
                                                                                    min = 0, value = 1)),
                                                                column(3, 
                                                                       numericInput("number", label = h3("Yield (AMD)"), 
                                                                                    min = 0, value = 1000))
                                                              ),
                                                              em("Cost",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(3, 
                                                                       numericInput("number", label = h3("Units"), 
                                                                                    min = 0, value = 1)),
                                                                column(3, 
                                                                       numericInput("number", label = h3("Cost (AMD)"), 
                                                                                    min = 0, value = 1000))
                                                              )
                                                     ),
                                                     tabPanel("Help",
                                                              
                                                              column(3, 
                                                                     h3("Help text"),
                                                                     helpText("You can get help from this page,", 
                                                                              "it provides an easy way to add text to",
                                                                              "accompany other widgets.",style = "color: grey"))
                                                     )
                                          )),
                                 tabPanel("Livestock",
                                          tabsetPanel("",
                                                     tabPanel("Input data",
                                                              em("General input",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4, 
                                                                       textInput("text", label = h3("Crop type"), 
                                                                                 placeholder = "Please enter the crop name", width = "85%")),
                                                                column(4,
                                                                       selectInput("select", label = h3("Measurement Unit"), 
                                                                                   choices = list("ha", "units"), selected = 1, width = "85%"))          
                                                              ),
                                                              br(),
                                                              em("Yield",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4,
                                                                       numericInput("number", label = h3("Standard yearly income yield / unit"),
                                                                                    min = 0, value = 0,  width = "85%"))
                                                              ),
                                                              br(),
                                                              em("Cost",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4,
                                                                       numericInput("number", label = h3("Replacement cost / unit"),
                                                                                    min = 0, value = 0,  width = "85%")),
                                                                column(4,
                                                                       numericInput("number", label = h3("Recovery cost / unit"),
                                                                                    min = 0, value = 0,  width = "85%"))           
                                                              )
                                                              # column(3, offset = 7,
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        submitButton("Submit",width = "30%"))
                                                     ),
                                                     tabPanel("Calculator",
                                                              em("Yield",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(3, 
                                                                       numericInput("number", label = h3("Units"), 
                                                                                    min = 0, value = 1)),
                                                                column(3, 
                                                                       numericInput("number", label = h3("Yield (AMD)"), 
                                                                                    min = 0, value = 1000))
                                                              ),
                                                              em("Cost",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(3, 
                                                                       numericInput("number", label = h3("Units"), 
                                                                                    min = 0, value = 1)),
                                                                column(3, 
                                                                       numericInput("number", label = h3("Cost (AMD)"), 
                                                                                    min = 0, value = 1000))
                                                              )
                                                     ),
                                                     tabPanel("Help",
                                                              
                                                              column(3, 
                                                                     h3("Help text"),
                                                                     helpText("You can get help from this page,", 
                                                                              "it provides an easy way to add text to",
                                                                              "accompany other widgets.",style = "color: grey"))
                                                     )
                                          )),
                                 tabPanel("Assets and equipment",
                                          tabsetPanel("",
                                                     tabPanel("Input data",
                                                              em("General input",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4, 
                                                                       textInput("text", label = h3("Crop type"), 
                                                                                 placeholder = "Please enter the crop name", width = "85%")),
                                                                column(4,
                                                                       selectInput("select", label = h3("Measurement Unit"), 
                                                                                   choices = list("ha", "units"), selected = 1, width = "85%"))          
                                                              ),
                                                              br(),
                                                              
                                                              em("Cost",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4,
                                                                       numericInput("number", label = h3("Replacement cost / unit"),
                                                                                    min = 0, value = 0,  width = "85%")),
                                                                column(4,
                                                                       numericInput("number", label = h3("Repair cost / unit"),
                                                                                    min = 0, value = 0,  width = "85%"))           
                                                              )
                                                              # column(3, offset = 7,
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        submitButton("Submit",width = "30%"))
                                                     ),
                                                     tabPanel("Calculator",
                                                              em("Yield",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(3, 
                                                                       numericInput("number", label = h3("Units"), 
                                                                                    min = 0, value = 1)),
                                                                column(3, 
                                                                       numericInput("number", label = h3("Yield (AMD)"), 
                                                                                    min = 0, value = 1000))
                                                              ),
                                                              em("Cost",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(3, 
                                                                       numericInput("number", label = h3("Units"), 
                                                                                    min = 0, value = 1)),
                                                                column(3, 
                                                                       numericInput("number", label = h3("Cost (AMD)"), 
                                                                                    min = 0, value = 1000))
                                                              )
                                                     ),
                                                     tabPanel("Help",
                                                              
                                                              column(3, 
                                                                     h3("Help text"),
                                                                     helpText("You can get help from this page,", 
                                                                              "it provides an easy way to add text to",
                                                                              "accompany other widgets.",style = "color: grey"))
                                                     )
                                          )),
                                 tabPanel("Infrastructure and land",
                                          tabsetPanel("",
                                                     tabPanel("Input data",
                                                              em("General input",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4, 
                                                                       textInput("text", label = h3("Crop type"), 
                                                                                 placeholder = "Please enter the crop name", width = "85%")),
                                                                column(4,
                                                                       selectInput("select", label = h3("Measurement Unit"), 
                                                                                   choices = list("ha", "units"), selected = 1, width = "85%"))          
                                                              ),
                                                              br(),
                                                              em("Yield",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4,
                                                                       numericInput("number", label = h3("Standard yearly income yield / unit"),
                                                                                    min = 0, value = 0,  width = "85%")),
                                                                column(4,
                                                                       numericInput("number", label = h3("Replanted income yield / unit"),
                                                                                    min = 0, value = 0,  width = "85%"))            
                                                              ),
                                                              br(),
                                                              em("Cost",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(4,
                                                                       numericInput("number", label = h3("Replacement cost / unit"),
                                                                                    min = 0, value = 0,  width = "85%")),
                                                                column(4,
                                                                       numericInput("number", label = h3("Repair cost / unit"),
                                                                                    min = 0, value = 0,  width = "85%"))            
                                                              )
                                                              # column(3, offset = 7,
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        br(),
                                                              #        submitButton("Submit",width = "30%"))
                                                     ),
                                                     tabPanel("Calculator",
                                                              em("Yield",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(3, 
                                                                       numericInput("number", label = h3("Units"), 
                                                                                    min = 0, value = 1)),
                                                                column(3, 
                                                                       numericInput("number", label = h3("Yield (AMD)"), 
                                                                                    min = 0, value = 1000))
                                                              ),
                                                              em("Cost",
                                                                 style = "font-family: 'times'; font-size: 16pt; color: green"),
                                                              fluidRow(
                                                                
                                                                column(3, 
                                                                       numericInput("number", label = h3("Units"), 
                                                                                    min = 0, value = 1)),
                                                                column(3, 
                                                                       numericInput("number", label = h3("Cost (AMD)"), 
                                                                                    min = 0, value = 1000))
                                                              )
                                                     ),
                                                     tabPanel("Help",
                                                              
                                                              column(3, 
                                                                     h3("Help text"),
                                                                     helpText("You can get help from this page,", 
                                                                              "it provides an easy way to add text to",
                                                                              "accompany other widgets.",style = "color: grey"))
                                                     )
                                          ))
                                 
                      
                    )),
           navbarMenu('Reports',
                      tabPanel("Table",
                               DT::dataTableOutput("responses")
                               ),
                      tabPanel("Visual",
                               sidebarPanel(
                                 em("Graph damages and Losses by:"),
                                 selectizeInput("baroptions","", choices = fields)
                               ),
                               mainPanel(
                                 plotOutput("plot"),
                                 DT::dataTableOutput("damloss")
                               )
                               )
                      )
)