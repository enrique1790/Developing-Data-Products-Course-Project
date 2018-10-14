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
 
 fileext <- reactive({
   switch(input$type, 
          "Excel (CSV)" = "vsv", "Text (TSv)" = "txt", "Text (Space Separated)" = "txt", "Doc" = "doc")
 })
 
 
 output$table <-renderTable({
   datasetInput()
   
 })
 
 output$downloadData <- downloadHandler(
   
   filename = function(){
     paste(input$dataset, fileext(), sep=".")
   
     },
   
   content = function(file){
     sep <- switch(input$type, "Excel (CSV)" = ",", "Text (TSV)" = "\t", "Text (Space Separated)" = " ", "Doc" = " ")
    
     write.table(datasetInput(), file, sep = sep,
                 row.names = FALSE)
  
 
 }
 )
}
 
 
 