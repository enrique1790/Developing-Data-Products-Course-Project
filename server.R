library(shiny)
# Define server logic to display and download selected file ----
function(input, output) { 
 datasetInput <- reactive({
   switch(input$dataset,
          "iris" = iris,
          "mtcars" = mtcars,
          "pressure" = pressure,
          "trees" = trees,
          "faithful" = faithful)
 
 })
 
 ##### A reactive function for the file extension ---- > this reactive function will be used by download handler ######
 fileext <- reactive({
   switch(input$type,
          "Excel (CSV)" = "csv", "Text (TSV)" = "txt","Text (Space Separated)" = "txt", "Doc" = "doc")
   
 })
 
 ### Output of renderTable will be used in the mainPanel of ui.R to display the dataset observations in the table
 output$table <- renderTable({
   datasetInput()
   
 })
 
 ############ Download handler for the download button ####################
 # downloadHandler() takes two arguments, both functions.
 # The content function is passed a filename as an argument, and
 #   it should write out data to that filename.
 output$downloadData <- downloadHandler(
   
   # This function returns a string which tells the client
   # browser what name to use when saving the file.
   filename = function() {
     paste(input$dataset, fileext(), sep = ".") # example : iris.csv, iris.doc, iris.txt 
     
   },
   
   # This function should write data to a file given to it by
   # the argument 'file'.
   content = function(file) {
     sep <- switch(input$type, "Excel (CSV)" = ",", "Text (TSV)" = "\t","Text (Space Separated)" = " ", "Doc" = " ")
     
     # Write to a file specified by the 'file' argument
     write.table(datasetInput(), file, sep = sep,
                 row.names = FALSE)
   }
 )
}
 
 
