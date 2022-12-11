library("stringr")
library("dplyr")
library("tidyr")
library("ggplot2")
library("plotly")
library("reshape2")

co2_emissions <- read.csv("owid-co2-data.csv")
co2_emissions_by_year <- co2_emissions %>%
  group_by(year) %>%
  summarise(
    co2 = sum(co2, na.rm = TRUE),
    co2_growth_abs = sum(co2_growth_abs, na.rm = TRUE),
    co2_growth_prct = sum(co2_growth_prct, na.rm = TRUE),
    co2_including_luc = sum(co2_including_luc, na.rm = TRUE),
    co2_including_luc_growth_abs = sum(co2_including_luc_growth_abs, na.rm = TRUE),
    co2_including_luc_growth_prct = sum(co2_including_luc_growth_prct, na.rm = TRUE)
  )
year_range <- range(co2_emissions_by_year$year)
co2_2000 <- co2_emissions_by_year %>% 
  filter(year == "2000") %>% 
  pull(co2)

co2_growth_abs_2000 <- co2_emissions_by_year %>% 
  filter(year == "2000") %>% 
  pull(co2_growth_abs)

co2_growth_prct_2000 <- co2_emissions_by_year %>% 
  filter(year == "2000") %>% 
  pull(co2_growth_prct)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$line_chart <- renderPlotly({
    line_data <- co2_emissions_by_year %>%
      filter(year > input$year_range[1], year < input$year_range[2]) %>%
      select(year, input$data_type) %>%
      melt(id.vars = "year", measure.vars = input$data_type)

    line_chart <- ggplot(line_data) +
      aes(x = year, y = value, color = variable) + 
      geom_line() + 
      labs(x = "Year", y = "CO₂ data Type", 
           title = "Various Types of CO₂ Emissions Data with Resepct to Specific Year Range") + 
      theme_bw() +
      theme(rect = element_rect(fill = "transparent")) 

    return(line_chart)
  })
}
