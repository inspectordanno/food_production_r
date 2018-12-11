library(shiny)
library(tidyverse)

##load food data
load(file = "../countriesbyFood.rdata")

# Define UI
ui <- fluidPage(
   
   # Application title
   titlePanel("Distribution of Food vs Feed"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput(inputId= "Region",
                     label= strong("Region"),
                     choices = unique(countriesbyFood$SUBREGION),
                     selected = countriesbyFood$SUBREGION[1]),
         
         selectInput(inputId= "Food",
                     label= strong("Food Item"),
                     choices = unique(countriesbyFood$Item),
                     selected = countriesbyFood$Item[1]),
         
         selectInput(inputId= "Scale",
                     label= strong("Scale"),
                     choices = c("Logarithmic", "Linear"),
                     selected = "Logarithmic")
         
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     Food <- input$Food
     Region <- input$Region
     log <- input$Scale
     
     tmpServer <- countriesbyFood[countriesbyFood$Item==Food & countriesbyFood$SUBREGION==Region,]
     g <- ggplot(tmpServer) + geom_line(aes(color = Element, x = Year, y = Amount)) + facet_wrap(~Area)
     
     if (log == "Logarithmic") {g + scale_y_log10()} else {g}
       
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

