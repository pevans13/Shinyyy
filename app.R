#install.packages("shiny")
#install.packages('rsconnect')

library(rsconnect)
library(shiny)

Dinosaurs <- read.csv("c:/Users\\paueva\\OneDrive for Business\\ShinyApp\\PE_tryone/data/Dinos2.csv")

ui <- fluidPage(
  titlePanel("Paul's T-rex App"),
  textInput("a",""),
  sidebarLayout(
    sidebarPanel(h2("Biography of Terrance"),
                 p("Terry the T-rex, as he is know to friends, likes to party of solve algebraic equations. Find out more about this spirited individual here:"),
                 code("www.Itsterrysnotyours.co.dino"),
                 br(),
                 h4("Here is Terry is his younger days:"),
                 img(src = "tr1.jpg"),
                 
                 # Start actions
            #     selectInput('xcol', 'Age', Dinosaurs$Age),
            #     selectInput('ycol', 'Legs', Dinosaurs$Legs),
                 hr()),
    
    # main panel
    mainPanel(h2("Introducing Terry"),
              "T-rex",em("is very sad."),"The reason is because his peers do not think he is cool.",
              "For those nasty creatures, visit:",
              a("www.dinopoo.com"),
              br(),
              
              # Start actions
          #    checkboxGroupInput("checkGroup", 
          #                       h3("Do you like Terry?"), 
          #                       choices = list("Yes" = 1, 
          #                                      "Very much so" = 2, 
          #                                      "He is really cool" = 3)),
              sliderInput("Coolness_bar",label=h3("How cool is Terry?"),
                          value = 43,max = 74.8,min = 2.6),
              br(), 
          #    selectInput("var", 
          #                label = "Choose an attribute",
          #                choices = c("Legs", 
          #                            "Arms",
          #                            "Brains", 
          #                            "Beauty"),
          #                selected = "Arms"),
              textOutput("selected_var"),
              textOutput("selected_score"),
              hr(),
              fluidRow(column(4,
                              h3("Make Terry happy?"),
                              actionButton("action22", label = "Make sad"),
                              actionButton("action", "Make happy"))),
              plotOutput("DinoPlot"),
              # Add button to allow download of data
              downloadButton("downloadData", "Download")
    )
  )
)


server <- function(input, output) {
  rv <- reactiveValues()
  rv$number <- 5
  output$selected_var <- renderText({ 
    paste("You have selected", input$var)
  })
  output$selected_score <- renderText({ 
    paste("You have rated", input$Coolness_bar)
  })
  # Fill in the spot we created for a plot
  output$DinoPlot <- renderPlot({
    # Render a barplot
    hist(Dinosaurs$Age, 
         ylab="Number of Telephones",
         xlab="Year")
  })
  output$value <- renderPrint({
    input$action22
  })
  # Downloadable csv of selected dataset ----
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataset, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    })
}

shinyApp(ui = ui, server = server)