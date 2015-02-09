###If the recent Shiny update broke the links in your renderDataTable:

####My problem:  
I use a datatable in Shiny to render out a dataframe with some links in it to make my life much (much) easier.  
The new Shiny update uses the new datatables update which makes you escape those links.  
For whatever reason, it doesnt seem to work for me.
This datatable also needs to be themed out a little or my users complain about it being ugly and unprofessional.

After a bit of puttering I found the DT package (which will soon deprecate use of renderDataTable in Shiny I would guess). 

But a simple 
```R
library(DT)
library(shinythemes)
datatable(Your_Data_Frame, escape= -1, options = list(iDisplayLength = 25))
```
does give me the link but didn't seem to work with the theme, no matter where I put it in the line. 

After a bit of looking around, I found a hack that works. You wrap your DT output in Shiny. 

In this example below, column 1 has a link in it like `<a html="http://www.whatever.com">Tevs</a>`. 

Step 1:
* Go get [The new DT tables package here.](https://rstudio.github.io/DT/)
* Install the shinythemes package as well. 

```R
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
```
So essentially youre using shiny to show your DT rendering but this way you get to theme it out.  
I suspect that soon that theming will be built into the DT package. 
