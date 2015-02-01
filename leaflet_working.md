# Getting the Leaflet Package To Work in R

Saturday, January 31, 2015  

I'm not entirely sure why, but the Shiny example from the [Leaflet write-up on R-Bloggers](http://www.r-bloggers.com/the-leaflet-package-for-online-mapping-in-r/) didn't work for me.

Here's the example given:


```r
library(shiny)
library(leaflet)
shinyApp(
  ui = fluidPage(leafletOutput('myMap')),
  server = function(input, output) {
    
    # download and load data
    url = "https://github.com/Robinlovelace/sdvwR/raw/master/data/gps-trace.gpx"
    download.file(url, destfile = "shef2leeds.gpx", method = "wget", )
    library(rgdal)
    shef2leeds <- readOGR("shef2leeds.gpx", layer = "tracks")
    
    map = leaflet() %>% addTiles() %>% setView(-1.5, 53.4, 9) %>% 
      addPolylines(data = shef2leeds, color = "red", weight = 4)
    output$myMap = renderLeaflet(map)
  }
)
```


I kept getting this:



> Warning messages:
> 1: running command 'wget  "https://github.com/Robinlovelace/sdvwR/raw/master/data/gps-trace.gpx" -O "shef2leeds.gpx"' had status 127 
> 2: In download.file(url, destfile = "shef2leeds.gpx", method = "wget") :
  download had nonzero exit status  


I have no idea what's up with that. And given the error message, it smelled like some sort of wget thing.  

I went looking at the download.file() function and found [the downloader RCRAN package](http://cran.r-project.org/web/packages/downloader/downloader.pdf).  

The download() function is a wrapper for download.file() and seems like the thing to handle all of the things that might get messed up by download.file() in the example above.  

Changing download.file(url, destfile = "shef2leeds.gpx", method = "wget", ) to download(url, "shef2leeds.gpx", mode = "wb") did the trick. 


```r
library(shiny)
library(downloader)
library(leaflet)
shinyApp(
    ui = fluidPage(leafletOutput('myMap')),
    server = function(input, output) {
        
        # download and load data
        url = "https://github.com/Robinlovelace/sdvwR/raw/master/data/gps-trace.gpx"
        
        download(url, "shef2leeds.gpx", mode = "wb")
        
        library(rgdal)
        shef2leeds <- readOGR("shef2leeds.gpx", layer = "tracks")
        
        map = leaflet() %>% addTiles() %>% setView(-1.5, 53.4, 9) %>% 
            addPolylines(data = shef2leeds, color = "red", weight = 4)
        output$myMap = renderLeaflet(map)
    }
)
```


Which gets me a lovely map:  

![That's a long ride.](http://i.imgur.com/tniXD3P.jpg)

And everything works just peachy.

Big thanks to the R Studio team for putting this package together and R-Bloggers for the post about it.
I'd never have found it otherwise.
