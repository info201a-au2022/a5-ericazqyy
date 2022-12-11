library("shiny")
library("plotly")
library("shinyWidgets")
library("shinythemes")


source("app_server.R")

intro_page <- tabPanel(
  "Introduction",
  h1("Exploring Six Types of CO₂ Emission Data", style = " font-size: 40px ; font-family: 'times'; font-si16pt"),
  img("", src = "https://media.istockphoto.com/id/167231386/photo/detail-of-white-smoke-polluted-sky.jpg?s=612x612&w=0&k=20&c=hExCnY1CN7xieBUcBTQ8h37TDLkSWCT06l8bbShbQvE=",
      style = "display: block; margin-left: auto; margin-right: auto;", height = 600, width = 1400),
  br(),
  p(paste0("As climate change can literally affect anyone on this planet, it is significantly
    important for us to get more aware of it. And CO₂ emission trend is a big part of it.
    This application focused specifically on 6 types of CO₂ emission to explore,
    in order to provide an analysis and visualization of the trend of CO₂ emission globally.
    In detail, the variables of CO₂ included are the annual total production-basd of
    CO₂ emission(excluding land-use change), the annual growth and the annual percentage
    growth of it. As well as the annual total production-basd of CO₂ emission that
    included land-use change, and the annual growth and annual percentage growth of it.
    These 6 variables can reveal a general trend of CO₂ emission and also explore how the
    factor of land-use change can play a role in CO₂ emission. To first get a sense of the
    CO₂ emission, I would like to introduce the three relevant values of CO₂ for the year 2000.
    In the year 2000, the total CO₂ emission(excluding land-use change) was ", co2_2000,
    "tonnes, the annual growth was ", co2_growth_abs_2000, "tonnes, and the annual percentage growth was ", co2_growth_prct_2000,
    "%. "),
    style = "font-family: 'times'; font-si16pt ; font-size:17px;"
  )
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
  h1("Visualizing the Trends of Different CO₂ Data Type", style = " font-size: 40px ; font-family: 'times'; font-si16pt"),
  br(),
  setSliderColor("#515A5A", 1),
  year_input,
  select_input,
  plotlyOutput(outputId = "line_chart"),
  p("This chart was included to visualize the trend of 6 different CO₂ emission data types 
    with respect to a specific year range. The user could easily get a clear sense of the 
    circumstance of  CO₂ emission during a particular year range they are interested in. 
    From this chart, we could see that CO₂ emission grew dramatically starting the year 1850, 
    and land-use change played a big role during the years 1850 to 1950. Besides, 
    variables of growth and percentage growth also started to have a lot of float starting 1850. "
    , style = "font-family: 'times'; font-si16pt ; font-size:17px;"),
)

ui <- navbarPage(
  "CO₂ Emission",
  theme = shinythemes::shinytheme("sandstone"),
  setBackgroundColor("#f9f7f1"),
  intro_page,
  interactive_page
)
