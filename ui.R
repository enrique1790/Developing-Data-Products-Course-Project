library(shiny)

# Define UI for data download app ----
fluidPage(
  
  # App title ----
  titlePanel("Downloading Data using downloadbutton() and downloadHandler()"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Choose dataset ----
      selectInput("dataset", "Choose a dataset:",
                  choices = c("mtcars", "pressure", "iris", 
                              "faithful","trees")),
      br(),
      helpText(" Select the download format"),
      radioButtons("type", "Format type:",
                   choices = c("Excel (CSV)", "Text (TSV)","Text (Space Separated)", "Doc")),
      br(),
      helpText("Click on the download button to download the dataset observation"),
      
      # Button
      downloadButton('downloadData', 'Download')
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      tableOutput('table')
      
    )
    
  )
)
