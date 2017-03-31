
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("DAX: Das wurde aus einem monatlich angelegten Euro im Durchschnitt"),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("months",
                  "Zeitraum der monatlichen Anlage:",
                  min = 1,
                  max = 480,
                  value = 120),
      helpText("Preisbereinigt, berechnet auf der Grundlage aller Anlageperioden zwsichen 1 und 480 Monaten von 1960 bis 2015. Details in: Warum Aktiensparen sich lohnt, D. Ulbricht, Der Neue Finanzberater, Oktober 2016")
    ),
    # Show a plot of the generated distribution
    mainPanel(
      # plotOutput("distPlot1")
      plotOutput("distPlot2")
    )
  )
)
)