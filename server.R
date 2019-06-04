#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(shinydashboard)
library(DT)
library(googleVis)
library(shiny)
library(plotly)
library(corrplot)



function(input, output){
  output$map <- renderGvis({
    gvisMap(locations, "lat_lon", "Manager")

  })
  
output$hist <- renderGvis({
    gvisHistogram(nav_stat[,input$price_choice, drop=FALSE], option=list(title="GS Blue Chip Fund"))

  })

output$hist_bench <- renderGvis({
  gvisHistogram(return_stats[,input$return_choice, drop=FALSE], option=list(title="S&P 500 Index distribution"))
  
})

output$fund_series <- renderPlot({
 if(input$price_choice == 'Open'){
    
    return(ggplot(nav_fund, aes(x = Date, y = Open)) +
     geom_line() + ggtitle("Blue Chip Prices") + ylab("Price") + xlab("Date"))
 }
 if(input$price_choice == 'Close'){
   
   return(ggplot(nav_fund, aes(x = Date, y = Open)) +
            geom_line() + ggtitle("Blue Chip Prices") + ylab("Price") + xlab("Date"))
}
   
})


output$fund_Table = renderDataTable({
  return(nav_fund)
})

output$benchmark_Table = renderDataTable({
  return(bench_fund)
})



output$walm_table = renderDataTable({
  return(walmart_equity)
})

output$walm_plot = renderPlot({
  return(ggplot(walmart_equity, aes(x = Date, y = Open)) +
           geom_line() + ggtitle("WMT") + ylab("Price") + xlab("Date"))
})

output$V_Table = renderDataTable({
  return(visa_equity)
})

output$unionpac_table = renderDataTable({
  return(union_pac_equity)
})

output$txn_table = renderDataTable({
  return(txn_equity)
})

output$msft_table = renderDataTable({
  return(msft_equity)
})

output$lly_table = renderDataTable({
  return(lly_equity)
})

output$hon_table = renderDataTable({
  return(hon_equity)
})

output$gspc_table = renderDataTable({
  return(gspc_equity)
})

output$dhr_table = renderDataTable({
  return(dhr_equity)
})

output$aapl_table = renderDataTable({
  return(aapl_equity)
})

output$fb_table = renderDataTable({
  return(fb_equity)
})


output$plot_stocks <- renderPlotly({
  portfolio_lines = plot_ly(data, x = ~Date, y = ~Close_wal_equity, name = 'Walmart', type = 'scatter', mode = 'lines') %>% 
    add_trace(y = ~Close_lly_equity, name = 'Eli Lilly And Co', mode = 'lines+markers') %>% 
    add_trace(y = ~Close_dhr_equity, name = 'Danaher Corporation', mode = 'lines+markers') %>% 
    add_trace(y = ~Close_aapl_equity, name = 'Apple Inc', mode = 'lines+markers') %>% 
    add_trace(y = ~Close_fb_equity, name = 'Facebook', mode = 'lines+markers') %>% 
    add_trace(y = ~Close_hon_equity, name = 'Honeywell', mode = 'lines+markers') %>% 
    layout(yaxis = list(title = "Closing Prices"))
  
})


output$corrlations_wal_lly <- renderPlot({
  corr_var <- corrplot(corr_vars, method = "circle", title = "ρWalmart,Elli Lilly and Co. Matrix", mar = c(0, 0, 2, 0))
  
})


output$corrlations_hon_dhr <- renderPlot({
  corr_varation <- corrplot(corr_var_2, method = "circle", title = "ρHoneywell,Danaher Corp. Matrix", mar = c(0, 0, 2, 0))
  
})


output$corrlations_fb_aapl <- renderPlot({
  corr_tech <- corrplot(corr_var_tech, method = "circle")
  
})



output$series_blue_chip <- renderPlot({
  
  return(ggplot(nav_fund, aes(x = Date, y = Open)) +
                geom_line() + ggtitle("GS Blue Chip Fund") + ylab("Price") + xlab("Date"))
  
  # if(input$price_choice == "Close"){
  #   prices_gs_blue_chip = nav_fund %>% group_by(Date) %>% 
  #     summarise(Total_Champ = mean(High))
  #   return(ggplot(nav_fund, aes(x = Close)) +
  #            geom_histogram() + 
  #            ggtitle("Blue Chip Prices"))
    
    }) 

}


