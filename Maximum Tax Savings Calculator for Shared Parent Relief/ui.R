shinyUI(fluidPage(
  titlePanel("Tax Savings Calculator"),
  navbarPage("",
             tabPanel("Overview",
                      sidebarLayout(
                        sidebarPanel(
                          
                          helpText(p("The purpose of this calculator is to compute the maximum tax savings for Parent Relief shared between 2 claimants."),
                                   p("Maxiumum tax savings is defined as the difference between total tax payable before applying Parent Relief and the total tax payable after applying Parent Relief."), 
                                   p("The Net Chargeable Income to be inputted is the net chargeable income before applying Parent Relief."),
                                   p("Under the Scenario tab, the calculator computes some of the common scenarios of sharing the relief to achieve maximum tax savings." ),
                                   p("Under the Table tab, the calculator computes all possible combination of the relief shared between 2 claimants that will yield maximum tax savings.")),
                          
                          numericInput(
                            inputId = "income1",
                            label = strong("Net Chargeable Income of Person 1"),
                            value = NULL
                          ),
                          
                          numericInput(
                            inputId = "income2",
                            label = strong("Net Chargeable Income of Person 2"),
                            value = NULL
                          ),
                          
                          numericInput(
                            inputId = "relief",
                            label = strong("Relief"),
                            value = NULL
                          ),
                          
                          actionButton(inputId = "AB", label = "Calculate"),
                          actionButton("reset", "Clear")
                        ),
                        
                        mainPanel(
                          h4("Maximum Tax Savings"),
                          verbatimTextOutput("max"),
                          hr(),
                          h4("Graph of Possible Relief Combinations to achieve Maximum Tax Savings"),
                          plotOutput("plot"),
                          fluidRow(
                            column(6,htmlOutput("summary1")),
                            column(6,htmlOutput("summary2"))
                          )
                        ))
             ),
             tabPanel("Scenario",
                      h4("Standard Scenarios to achieve Maximum Tax Savings"),
                      htmlOutput("scenario")),
             tabPanel("Table",
                      h4("Possible Relief Combinations to achieve Maximum Tax Savings"),
                      DT::dataTableOutput("table"))
  )
))