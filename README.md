
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lzstringr

<!-- badges: start -->
<!-- badges: end -->

The goal of lzstringr is to provide an R wrapper for the [lzstring C++
library](https://github.com/andykras/lz-string-cpp). lzstring is a
JavaScript library that provides fast and efficient string compression
and decompression. Credit goes to Winston Chang for spotting this
missing R package and doing the majority of the work over at the
Shinylive repo—check out his awesome contributions which this repo is
based on [here](https://github.com/posit-dev/r-shinylive/issues/70) and
[here](https://github.com/posit-dev/r-shinylive/pull/71). Also, shoutout
to Andy Kras for his original implementation in C++ of lzstring, which
you can find right [here](https://github.com/andykras/lz-string-cpp),
and [pieroxy](https://github.com/pieroxy), the original brain behind
lzstring in JavaScript—peek at his work over
[here](https://github.com/pieroxy/lz-string).

## Installation

You can install the development version of lzstringr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("parmsam/lzstring-r")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(lzstringr)

data = "The quick brown fox jumps over the lazy dog!";

compressed = lzstringr::compressToBase64(data)
compressed
#> [1] "CoCwpgBAjgrglgYwNYQEYCcD2B3AdhAM0wA8IArGAWwAcBnCTANzHQgBdwIAbAQwC8AnhAAmmAOYBCIA"

decompressed = lzstringr::decompressFromBase64(compressed)
decompressed
#> [1] "The quick brown fox jumps over the lazy dog!"
```

``` r
x <- lzstringr::decompressFromEncodedURIComponent("NobwRAdghgtgpmAXGKAHVA6ASmANGAYwHsIAXOMpMAGwEsAjAJykYE8AKAZwAtaJWAlAB0IdJiw71OY4RBEBiAAQAROADM+cRQFUAkorVFGitKkWluUUooAmzAO6cTi3p1JEA5sxiKAtP98RAFdaRQAeX0VUKA84AH1OWhs4ehZ2ERFFRSUAQXRzWlJqLQDAiCzSQuLFAF5FITAACThqaiJFAGVefgBCBtwM8uzOpJSWKKgIFoMjRT5UINInUszFROTU4zr1scZ0uSGspV0IBdJETrpk40NjCy0IIJh6OGMiNUV6PmWA1azpUaME5nfZZMFzU6LXQ2Wr1MBfCCcfp-MHUKAvaiwhoAOSeLzeHwRnEQyMOYJgfFhAEYBmSsjAoAAPWEAVgADLTwVkAG5QahBLR1ADMbJRsiyAlpqyUAHlFmcLo1aG5PN4-L8hqg2qQ5aQQUR5VCYXUGjZlaQAArahqyWQKFTqTRrV7c16KNoeWgERSMOAARxCvph7lsDmcrncXlg6v8Ik4LrdEQMQQgBEqJHY80WuEUBr1iwEihAgyOiiVKqjPne5m4Whl1BhADEoIVuGogpiAOJwVjx4zKKxQGNlUv2Vs+-0CtxwGGPZ5u6tE6WKAAqrkUcEZqF9nESJBrVkUsSmzHITiHEdV0eVinszHQM4hzgIfOoy5Dvog1ytRGsIb4ZovuQB7nNKy5Uhgii6NYN4NL6UBprQroNCYX41q86hGFoPAGg2nxaFAixEAylQvq0rDLmCvq+JucAEIsj72LW5RZksiiZpCpAACREoWBCWBAsTLgATJB0FOHmZzmKwqBaDeQ5ar+qySYsXFmm4P7WEmn7ftq7DFmSzJJmoLYWO21BcfYpl8B4KJEuEkTxn67AUhA7CMpKigMoy7mecUgkWBgeawqxPHfIoADUihUnaZIRqCXKMpyXJMHAUAANZOHURLJeCxCYiaYDyAA7CyOQ5MoABCpJcp8RjXFiYBMYUcA1YlaL0I1ADq1mCQU8DmO0UyMtYrxBKg6blBxXnfMIeAovSLblIV5aRmq1ZWYUNn9XASJgGKqwAL6yIdgxKAAwvBwFdHwrAmPkKyIt0rB5Kg7AhLCIQ5n2rpbM6jC-bIYCHQAukAA")
y <- jsonlite::fromJSON(x)
cat(y$name)
#> app.R
cat(y$content)
#> library(shiny)
#> library(bslib)
#> 
#> # Define UI for app that draws a histogram ----
#> ui <- page_sidebar(
#> 
#>   # App title ----
#>   title = "Hello Shiny!",
#> 
#>   # Sidebar panel for inputs ----
#>   sidebar = sidebar(
#> 
#>     # Input: Slider for the number of bins ----
#>     sliderInput(
#>       inputId = "bins",
#>       label = "Number of bins:",
#>       min = 1,
#>       max = 50,
#>       value = 30
#>     )
#>   ),
#> 
#>   # Output: Histogram ----
#>   plotOutput(outputId = "distPlot")
#> )
#> 
#> # Define server logic required to draw a histogram ----
#> server <- function(input, output) {
#> 
#>   # Histogram of the Old Faithful Geyser Data ----
#>   # with requested number of bins
#>   # This expression that generates a histogram is wrapped in a call
#>   # to renderPlot to indicate that:
#>   #
#>   # 1. It is "reactive" and therefore should be automatically
#>   #    re-executed when inputs (input$bins) change
#>   # 2. Its output type is a plot
#>   output$distPlot <- renderPlot({
#>     x <- faithful$waiting
#>     bins <- seq(min(x), max(x), length.out = input$bins + 1)
#> 
#>     hist(
#>       x,
#>       breaks = bins,
#>       col = "#75AADB",
#>       border = "white",
#>       xlab = "Waiting time to next eruption (in mins)",
#>       main = "Histogram of waiting times"
#>     )
#>   })
#> }
#> 
#> # Create Shiny app ----
#> shinyApp(ui = ui, server = server)
```
