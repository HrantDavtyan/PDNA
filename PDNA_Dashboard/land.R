tabPanel("Infrastructure and Land",
         selectizeInput("land", "Select type",choices = land_list,
                        options = list(create = TRUE,placeholder = "Which type of infrastructure was affected?")),
         conditionalPanel(condition ="input.land!=''",
                          fluidRow(column(6,selectInput("unit_land","Measurement Unit", choices = list("Ha","M2"))),
                                   column(6,numericInput("all_units_land","All units",min = 0, value = 0))),
                          fluidRow(column(6,numericInput("damaged_land","Units Damaged",min = 0, value = 0)),
                                   conditionalPanel(condition ="input.damaged_land > 0",
                                                    column(6, sliderInput("damage_land","Share of Damage",
                                                                          min = 0, step = 5, max = 100, value = 75)))),
                          fluidRow(
                            conditionalPanel(condition="input.damage_land>=50",
                            column(6,numericInput("replcost_land","Replacement cost",min = 0, value = 0))),
                            conditionalPanel(condition="input.damage_land<50",
                            column(6,numericInput("reprcost_land","Repair cost",min = 0, value = 0)))),
                          fluidRow(column(2,actionButton("default_land","Use Defaults",
                                                         style = "background-color: #337ab7; border-color: #2e6da4;
                                                         color: white")))))