###If the recent Shiny update broke the links in your renderDataTable:

####My problem:  
I use a datatable in Shiny to render out a dataframe with some links in it to make my life much (much) easier.  
The new Shiny update uses the new datatables update which makes you escape those links.  
For whatever reason, it doesnt seem to work for me. 

After a bit of puttering I found the DT package which will soon deprecate use of renderDataTable in Shiny. 
So heres how you can have a happily linked and themed dataframe using the DT package and a little bit of hackery


Step 1:
* Go get [The new DT tables package here.](https://rstudio.github.io/DT/)
* Install the shinythemes package as well. 


`library(shiny)
library(shinythemes)
shinyApp(
    ui = fluidPage(theme = shinytheme("cosmo"), DT::dataTableOutput('tbl')),
    server = function(input, output) {
        output$tbl = DT::renderDataTable({
            datatable(Your_Data_Frame, escape= -1, options = list(iDisplayLength = 25))
        })
    }
)`

So essentially youre using shiny to show your DT rendering but this way you get to theme it out.  
I suspect that soon that theming will be built into the DT package. 
