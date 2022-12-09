library("shiny")
library("plotly")
library("shinyWidgets")
library("shinythemes")


source("app_server.R")

intro_page <- tabPanel(
  "Introduction",
)

year_input <- sliderInput(
  inputId = "year_range",
  label = "Select Year",
  min = year_range[1],
  max = year_range[2],
  value = year_range, 
  width = "75%"
)

select_input <- selectInput(
  inputId = "data_type",
  label = "CO₂ data Type",
  choices = list(
    "CO₂ Annual Total" = "co2",
    "CO₂ Annual Growth" = "co2_growth_abs",
    "CO₂ Annual Percentage Growth" = "co2_growth_prct",
    "CO₂ Annual Total(Including Land-use Change)" = "co2_including_luc",
    "CO₂ Annual Growth(Including Land-use Change)" = "co2_including_luc_growth_abs",
    "CO₂ Annual Percentage Growth(Including Land-use Change)" = "co2_including_luc_growth_prct"
  ),
  selected = "co2",
  multiple = TRUE,
)


interactive_page <- tabPanel(
  "Interative Visualization",
  setSliderColor("#515A5A", 1),
  year_input, 
  select_input, 
  plotlyOutput(outputId = "line_chart")
)

ui <- navbarPage(
  "CO₂ Emission",
  theme = shinythemes::shinytheme("sandstone"),
  setBackgroundColor("#f9f7f1"),
  intro_page,
  interactive_page
)