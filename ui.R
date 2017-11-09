
library(ggplot2)

shinyUI(fluidPage(
  titlePanel("Predict Diamond Price"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderCarat", "Carat", 0.2, 3.5, value = 0.7),
      checkboxInput("showModel1", "Show/Hide Carat Model", value = TRUE),
      sliderInput("sliderX", "X", 2.5, 10, value = 5),
      checkboxInput("showModel2", "Show/Hide X^4 Model", value = TRUE),
      tags$p("Click on Submit Button if you are ready"),
      submitButton("Submit")
    ),
    mainPanel(tabsetPanel(tabPanel("Data Summary",h4("Summary"),
                                   verbatimTextOutput("summary"),
                                   h5("Note: x1 = x^4")),
      tabPanel("Plot",
      fluidRow(
        column(2, align="right",
               plotOutput(outputId = "plot1", width  = "500px",height = "400px"),  
               plotOutput(outputId = "plot2", width  = "500px",height = "400px")
        )),
      h4("Predicted Price from Carat Model:"),
      textOutput("pred1"),
      h5("R-quare of Carat Model:"),
      textOutput("R1"),
      h4("Predicted Price from X^4 Model:"),
      textOutput("pred2"),
      h5("R-quare of X^4 Model:"),
      textOutput("R2"),
      h4("Model that predicts better: "),
      textOutput("Better")
    )
  )
  ))
))
