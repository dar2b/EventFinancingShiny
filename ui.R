#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(plotly)
library(DT)

shinyUI(
  dashboardPage(skin = "blue",
                dashboardHeader(title = "Event Financing "),
                dashboardSidebar(
                  sidebarUserPanel("Darien Bouzakis", image = 'https://s3.amazonaws.com/static.graphemica.com/glyphs/i500s/000/011/055/original/03C3-500x500.png?1275329355'),
                  sidebarMenu( id = "menu1",
                    menuItem("Home Dashboard", tabName = "home", icon = icon("map")),
                    menuItem("Fund Value", tabName = "funds", icon = icon("folder-open")),
                    menuItem("Equities", tabName = "stock", icon = icon("coins")),
                    menuItem("Equity Event or Component", tabName = "event", icon = icon("chart-line")),
                    menuItem("Data",     #tabName = "data", icon = icon("database"),
                             menuSubItem("Performing data", tabName = "performing", icon = icon("money-bill-wave")),
                             menuSubItem("Fund's Top 10 Holdings", tabName = "top_ten", icon = icon("database"))
                             )
                  ),
                  # selectizeInput("price_choice",
                  #                "Select Net Asset Value to Display",
                  #                price_choice[c(-1,-7)]),      ## Additional conditional panel for each tab
                  conditionalPanel(
                    condition = "input.menu1 == 'funds'",
                    selectInput("return_choice",
                                "Select Returns to Display",
                                choices = c("Open", "High", "Low", "Close",        # add bullets and histogram seperate page
                                            "Adj.Close"),
                                selected = "Close",
                                multiple = F)),
                  conditionalPanel(
                      condition = "input.menu1 == 'home'",  #right skew more macro-oriented considering GDP          
                    selectInput("price_choice",
                      "Select Net Asset Value to Display",
                      choices = c("Open", "High", "Low", "Close", 
                                "Adj.Close"),
                      selected = "Close",
                      multiple = F))
                  ),
                dashboardBody(
                  tabItems(
                  tabItem(tabName = "home",
                    fluidRow(
                      tabBox(width = 12, id = 'tab2', 
                        tabPanel("Mapping Funds", 
                           htmlOutput("map"), width = 12 ),
                        tabPanel("Actively Managed Distribution ",
                           tags$ul(id = "Graph1",
                              tags$b("Observation or analysis: "),
                              tags$li("Left skewed returns (the fund's trading Net Asset Value) are seen throughout the financing products' series or charts."),
                              tags$li("These distribution's, or plotted profitability, have been seen in most recent history through 'structured' products."),
                              tags$li("This can also be coupled with the native country's Gross Domestic Product.")))
                                            )),     
                    fluidRow(box(htmlOutput("hist"), height = 250, width = 200 ))),
                  
                    tabItem(tabName = "funds",
                            fluidRow(box(htmlOutput("hist_bench"), height = 350, width = 200)),
                            fluidRow(
                              #valueBoxOutput("test3")),
                                  box(width = 12, 
                                        height = "auto",
                                          plotOutput("series_blue_chip")
                              )
                            #"to be replaced with times series and link with VaR ((number of shares) * (price)), Hedging option 'value'"
                    )),
                    tabItem(tabName = "stock",
                            fluidRow(box(width = 12, height = 'auto',
                                  plotlyOutput("plot_stocks")),
                                  box(width = 6, height = 'auto', plotOutput("corrlations_wal_lly")),
                                  box(width = 6, height = 'auto', plotOutput("corrlations_hon_dhr"))
                                  
                                )),
                    tabItem(tabName = "event", 
                            tags$a(href="https://www.microsoft.com/en-us/p/surface-pro-6/8zcnc665slq5?activetab=pivot%3aoverviewtab", " Microsoft SurfacePro 6"),
                            tags$a(href="https://www.theverge.com/2018/10/2/17927510/microsoft-surface-pro-6-2018-intel-new-features-specs-price-release-date", " News release: October 2018"),
                            tags$br(),
                            tags$a(href="https://ark.intel.com/content/www/us/en/ark/products/series/122593/8th-generation-intel-core-i7-processors.html", "Intel's 8th Generation Processor"),
                            tags$br() #"to be replaced with event, product release date and name's components manufactured, and commodities pieces used"
                            # tabBox(box(width = 12, height = "auto", 
                            #              tabBox(width = 12, 
                            #                     tabPanel("Microsoft", dataTableOutput("msft_table")))))
                            ),
                            
                    tabItem(tabName = "performing",
                            fluidRow(box(width = 12, height = "auto",
                                  tabBox(width = 12, id = "tabset1",
                                         tabPanel("GS Blue Chip Fund", dataTableOutput("fund_Table")),
                                         tabPanel("S&P 500 Index", dataTableOutput("benchmark_Table")))
                                  )
                            )
                        ),
                    tabItem(tabName = "top_ten", 
                            fluidRow(box(width = 12, 
                                  height = "auto", 
                                  tabBox(width = 12, id = "tabset1", 
                                         tabPanel("Walmart", dataTableOutput("walm_table")),
                                         tabPanel("Visa", dataTableOutput("V_Table")),
                                         tabPanel("Union Pacific", dataTableOutput("unionpac_table")),
                                         tabPanel("Texas Instraments", dataTableOutput("txn_table")),
                                         tabPanel("Microsoft", dataTableOutput("msft_table")),
                                         tabPanel("Eli Lilly And Co", dataTableOutput("lly_table")),
                                         tabPanel("Honeywell International Inc.", dataTableOutput("hon_table")),
                                         tabPanel("Danaher Corporation", dataTableOutput("dhr_table")),
                                         tabPanel("Apple", dataTableOutput("aapl_table")),
                                         tabPanel("Facebook", dataTableOutput("fb_table"))
                                         )
                                      )
                                  )
                              ) 
                          )
                      )
                  )
              )
