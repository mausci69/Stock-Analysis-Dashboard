# Loading packages
library(shiny)
library(quantmod)
library(shinydashboard)

# ui side
dashboardPage(
  dashboardHeader(title = "Stock Analysis Dashboard"),
  dashboardSidebar(
    textInput("symb1", "1st Stock Symbol", ""),
    textInput("symb2", "2nd Stock Symbol", ""),
    tags$br(),
    tags$br(),
    dateRangeInput("dates",
                   "Date range",
                   start = "2013-01-01",
                   end = as.character(Sys.Date())),
    actionButton(inputId = "do",
                 label = "Search")
  ),
  dashboardBody(
    plotOutput("stockChart")
  )
)
