library(rsconnect)
library(XML)

forgetDeployment('C:/Users/daved/Documents/Data Science/p8105-Final-Project/shiny apps/shiny_dashboard.rmd')

rsconnect::setAccountInfo(name='davdestep',
                          token='D62DE606739C3D8DF76F354D962493FA',
                          secret='aifemNOW95DVmXqZ5u0q7ZoTH6uFnT2tkh7w0/20')

rsconnect::deployApp('C:/Users/daved/Documents/Data Science/p8105-Final-Project/shiny apps/shiny_dashboard.rmd')






setwd("C:/Users/daved/Documents/Data Science/p8105-Final-Project/shiny apps")

shiny::runApp()