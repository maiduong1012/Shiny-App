# Shiny-App to predict Diamond's price
This app is created based on the Diamonds data table stored in library(ggplot2)

Input:
Two variables that we are interested in is carat and X are used to predict the price.
Since the relationship of price and X is not linear, we created a new variable which is x1 = x^.
Two Univariate Linear Regression models are used to predict the price: price~ carat and price~X^4.

Output:
There are two tabs in the App: Plot and Data Summary
- Plots: Plots of the two model were created in one tab, predicted prices by 2 models, the better predicted model based on R-square
- Summary data: summary of used data (mean, min, max, etc.)
