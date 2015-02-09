library(shiny)
library(shinythemes)
shinyApp(
    ui = fluidPage(theme = shinytheme("cosmo"), DT::dataTableOutput('tbl')),
    server = function(input, output) {
        output$tbl = DT::renderDataTable({
            datatable(Your_Data_Frame, escape= -1, options = list(iDisplayLength = 25))
        })
    }
)