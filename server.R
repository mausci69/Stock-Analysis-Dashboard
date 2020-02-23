# Loading packages
library(shiny)
library(quantmod)
library(zoo)

# server side
function(input, output) {
# catch the button pressed
  observeEvent(input$do, {
    data1 <- tryCatch({getSymbols(toupper(input$symb1),
                                  from = input$dates[1],
                                  to = input$dates[2],
                                  auto.assign = FALSE)
    }, error = function(err) {
      NULL
    })
    data2 <- tryCatch({getSymbols(toupper(input$symb2),
                                  from = input$dates[1],
                                  to = input$dates[2],
                                  auto.assign = FALSE)
    }, error = function(err) {
      NULL
    })
# catch if the two symbols introduced are different
    if ((!is.null(data1)) & (!is.null(data2))) {
      stocks <- as.xts(data.frame(stock_a = data1[,6], stock_b = data2[,6]))
      if (toupper(input$symb1) != toupper(input$symb2)) {
        stcz <- c(isolate(toupper(input$symb1)), isolate(toupper(input$symb2)))
        colz <- c("red", "blue")
      } else {
        stcz <- isolate(toupper(input$symb1))
        colz <- "blue"        
      }
# draw the plot      
      output$stockChart <- renderPlot({
        plot(as.zoo(stocks),
             screens = 1,
             col = c("red", "blue"),
             xlab = "Date",
             ylab = "Price",
             main = paste(isolate(toupper(input$symb1)), " vs ", isolate(toupper(input$symb2))))
        legend("topleft",
               stcz,
               lty = 1,
               col = colz,
               cex = 1.2,
               box.lty = 0)
      })
    } else {
# show a message if one or both of the symbols are not found in Yahoo Finance
      showNotification("Please correct the code for your symbols")
    }
  })
}
