---
  title: "Shiny Dashboard"
output: 
  flexdashboard::flex_dashboard:
  orientation: columns
vertical_layout: fill
runtime: shiny
---
  
library(flexdashboard)
library(tidyverse)
library(viridis)
library(plotly)



files = list.files("./PRSA_Data_20130301-20170228", full.names = TRUE)

all<-map_df(files, read_csv) %>% 
  bind_rows() %>% 
  janitor::clean_names()



Column {.sidebar}
-----------------------------------------------------------------------
  
stations = all %>% distinct(station) %>% pull()

# selectInput widget
selectInput(
  "station_choice", 
  label = h3("Select station"),
  choices = stations, selected = "Dongsi")

#Year
years = all %>% distinct(year) %>% pull()

selectInput(
  "year_choice", 
  label = h3("Select Year"),
  choices = years, selected = "2016")

#Month
months = all %>% distinct(month) %>% pull()

selectInput(
  "month_choice", 
  label = h3("Select Month"),
  choices = months, selected = "1")

Column {data-width=650}
-----------------------------------------------------------------------
  
  ### Chart A
  
renderPlotly({
  all %>%
    filter(
      station == input$station_choice,
      year == input$year_choice,
      month == input$month_choice) %>%
    plot_ly(
      x = ~day, y = ~pm2_5, type = "scatter", mode = "markers",
      alpha = 0.5, color = ~rain)
})

Column {data-width=350}
-----------------------------------------------------------------------
  
  ### Chart B
#Run hour by hour
#(July and august are the rainiest months?)
renderPlotly({
  all %>%
    filter(
      station == input$station_choice,
      year == input$year_choice,
      month == input$month_choice) %>%
    plot_ly(
      x = ~no, y = ~pm2_5, type = "scatter", mode = "markers",
      alpha = 0.5, color = ~rain)
})


### Chart C
#Try using windspeed instead.
#will need to group variables for Color, so someone can pick which variable they want to look at (as the color) for each year, month and station
renderPlotly({
  all %>%
    filter(
      station == input$station_choice,
      year == input$year_choice,
      month == input$month_choice) %>%
    plot_ly(
      x = ~no, y = ~pm2_5, type = "scatter", mode = "markers",
      alpha = 0.5, color = ~wspm)
})

