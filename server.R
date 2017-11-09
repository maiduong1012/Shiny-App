
#' This app is built to predict diamond's price based on carat and x value 
#' data sample is "diamonds" stored in  library(ggplot2)
#' 
#' 
library(ggplot2)

shinyServer(function(input, output) {
  diamonds$x1 <- diamonds$x^4 #' create vector x1: x1=x^4
  model1 <- lm(price ~ carat, data = diamonds) #' Model to predict price on carat input
  model2 <- lm(price ~ x1, data = diamonds) #' Model to predict price on X input
  my_data <- data.frame(diamonds$carat,diamonds$x,diamonds$price, diamonds$x1)
 
   #' Reactive Input: sliderCarat
  model1pred <- reactive({
    caratInput <- input$sliderCarat
    predict(model1, newdata = data.frame(carat = caratInput))
  })
  #' Reactive Input: sliderX
  model2pred <- reactive({
    xInput <- input$sliderX
    predict(model2, newdata = data.frame(x = xInput, x1 = xInput^4))
  })
  
  #' Output Carat Model 
  output$plot1 <- renderPlot({
    caratInput <- input$sliderCarat
    
    plot(diamonds$carat, diamonds$price, xlab = "Carat", 
         ylab = "Price", 
         xlim = c(0.2, 3.5), ylim = c(300, 20000))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    points(caratInput, model1pred(), col = "blue", pch = 16, cex = 2)
  })
  
  #' Output X^4 Model
  output$plot2 <- renderPlot({
    xInput <- input$sliderX
    
    plot(diamonds$x1, diamonds$price, xlab = "X^4", 
         ylab = "Price", 
         xlim = c(40, 7000), ylim = c(300, 20000))
    if(input$showModel1){
      abline(model2, col = "red", lwd = 2)}
    points(xInput^4, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  #' Out put predicted value of Carat model 
  output$pred1 <- renderText({
    model1pred()
  })
  # Output R-quare value of Carat Model
  output$R1 <- renderText({
    summary(model1)$r.squared
  })
  
  #' Out put predicted value of X^4 model 
  output$pred2 <- renderText({
    model2pred()
  })
  # Output R-quare value of Carat Model
  output$R2 <- renderText({
    summary(model2)$r.squared
  })
  
  #' Output Model that predict better based on R-Quare value
  
  output$Better <- renderText({ifelse(summary(model2)$r.squared > summary(model1)$r.squared,"X^4 Model","Carat Model")
  
  })
  
  #' Output Summary data in "Summary data" Tab
  output$summary <- renderPrint({
    summary(my_data)
  })
})

