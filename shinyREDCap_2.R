---
title: "Shiny-REDCap dashboard"
author: "Luciano K. Silva"
date: "2024-12-20"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```


# API playground ----------------------------------------------------------

#!/usr/bin/env Rscript
token <- "39169DDCCC39AED2489284B828E0A65A"
url <- "https://bdp.bahia.fiocruz.br/api/"
formData <- list("token"=token,
                 content='project',
                 format='json',
                 returnFormat='json'
)
response <- httr::POST(url, body = formData, encode = "form")
result <- httr::content(response)
print(result)


```{r pressure, echo=FALSE}
library(shiny)
library(REDCapR)

# Define the UI for the application
ui <- fluidPage(
  titlePanel("REDCap Data Viewer"),
  sidebarLayout(
    sidebarPanel(
      textInput("api_url", "REDCap API URL"),
      textInput("api_token", "REDCap API Token")
    ),
    mainPanel(
      tableOutput("data_table")
    )
  )
)

# Define the server logic for the application
server <- function(input, output) {
  output$data_table <- renderTable({
    req(input$api_url, input$api_token)
    
    # Connect to REDCap and retrieve data
    redcap_connection <- redcap_connection(url = input$api_url, token = input$api_token)
    data <- redcap_read(redcap_uri = input$api_url, token = input$api_token)$data
    
    data
  })
}

# Run the application
shinyApp(ui = ui, server = server)

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
```

