library(shiny)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
  # Expression that generates a plot of the distribution. The expression
  # is wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically 
  #     re-executed when inputs change
  #  2) Its output type is a plot 
  #
  output$pharmMap <- renderLeaflet({
    leaflet(cvs_locations_df) %>%
      addTiles() %>%
      addCircleMarkers(color = "navy", radius=6, lng = ~longitude, lat = ~latitude, popup = ~statezip)
  })
  # plot CA points on top of a leaflet basemap
  output$caMap <- renderLeaflet({
    leaflet(cvs_CA_locations_df) %>%
      addTiles() %>%
      addCircleMarkers(color = "darkgreen", radius=6, lng = ~exact_lon, lat = ~exact_lat, popup = ~address)
  })
})