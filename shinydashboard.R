# Basic Dashboard
# Link https://rstudio.github.io/shinydashboard/index.html

install.packages("shinydashboard")

library(shinydashboard)

#Structure overview
#dashboardPage(
#  dashboardHeader(),
#  dashboardSidebar(),
#  dashboardBody()
#)

# Or
## Title page
#header <- dashboardHeader()
#sidebar <- dashboardSidebar()
#body <- dashboardBody()
#dashboardPage(header, sidebar, body)


## ui.R ##
ui <- dashboardPage(
  ## Title page
  dashboardHeader(title = "Basic dashboard"),
  ## Sidebar content
  dashboardSidebar(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th"))
  ),
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      # Second tab content
      tabItem(tabName = "widgets",
              h2("Widgets tab content")
      )
    )
  )
)

## Title page
header <- dashboardHeader(
  title = "Basic dashboard"
)

## Sidebar content
sidebar <- dashboardSidebar(
  menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
  menuItem("Widgets", tabName = "widgets", icon = icon("th"))
)

## Body content
body <- dashboardBody(
  tabItems(
    # First tab content
    tabItem(tabName = "dashboard",
            fluidRow(
              box(plotOutput("plot1", height = 250)),
              
              box(
                title = "Controls",
                sliderInput("slider", "Number of observations:", 1, 100, 50)
              )
            )
    ),
    # Second tab content
    tabItem(tabName = "widgets",
            h2("Widgets tab content")
    )
  )
)

u2 <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)
shinyApp(u2, server)
