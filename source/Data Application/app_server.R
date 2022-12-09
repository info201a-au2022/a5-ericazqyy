library("stringr")
library("dplyr")
library("tidyr")
library("ggplot2")
library("plotly")
library("reshape2")

# Define server logic required to draw a histogram
server <- function(input, output) {
  incarceration <- read.csv("/Users/ericazhang/Documents/info201/assignments/a5-ericazqyy/source/owid-co2-data.csv")
  incarceration_by_year <- incarceration %>%
    group_by(year) %>%
    summarise(
      co2 = sum(co2, na.rm = TRUE),
      co2_growth_abs = sum(co2_growth_abs, na.rm = TRUE),
      co2_growth_prct = sum(co2_growth_prct, na.rm = TRUE),
      co2_including_luc = sum(co2_including_luc, na.rm = TRUE),
      co2_including_luc_growth_abs = sum(co2_including_luc_growth_abs, na.rm = TRUE),
      co2_including_luc_growth_prct = sum(co2_including_luc_growth_prct, na.rm = TRUE)
    )
  year_range <- range(incarceration_by_year$year)
  
  output$line_chart <- renderPlotly({
    line_data <- incarceration_by_year %>%
      filter(year > input$year_range[1], year < input$year_range[2]) %>%
      select(year, input$data_type) %>%
      melt(id.vars = "year")

    line_chart <- ggplot(line_data) +
      aes(x = year, y = value, color = variable) + 
      geom_line() + 
      labs(x = "Year", y = "CO₂ data Type") +
      theme_bw() +
      theme(rect = element_rect(fill = "transparent"))

    return(line_chart)
  })
}
