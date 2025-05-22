
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lzstring

<!-- badges: start -->

[![R-CMD-check](https://github.com/parmsam/lzstring-r/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/parmsam/lzstring-r/actions/workflows/R-CMD-check.yaml)
[![Test
coverage](https://github.com/parmsam/lzstring-r/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/parmsam/lzstring-r/actions/workflows/test-coverage.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/lzstring)](https://CRAN.R-project.org/package=lzstring)
[![Monthly metacran
downloads](https://cranlogs.r-pkg.org/badges/lzstring)](https://cran.r-project.org/package=lzstring)
[![Total metacran
downloads](https://cranlogs.r-pkg.org/badges/grand-total/lzstring)](https://cran.r-project.org/package=lzstring)

<!-- badges: end -->

The goal of lzstring-r is to provide an R wrapper for the [lzstring C++
library](https://github.com/andykras/lz-string-cpp).
[lzstring](https://github.com/pieroxy/lz-string) is originally a
JavaScript library that provides fast and efficient string compression
and decompression using a [LZ-based
algorithm](https://en.wikipedia.org/wiki/Lempel–Ziv–Welch). Credit goes
to [Winston Chang](https://github.com/wch) for spotting this missing R
package and guiding me over at the R Shinylive repo—check out his
awesome contributions which this repo is based on
[here](https://github.com/posit-dev/r-shinylive/issues/70) and
[here](https://github.com/posit-dev/r-shinylive/pull/71). Also, shoutout
to Andy Kras for his implementation in C++ of lzstring, which you can
find right [here](https://github.com/andykras/lz-string-cpp), and
[pieroxy](https://github.com/pieroxy), the original brain behind
lzstring in JavaScript—peek at his work over
[here](https://github.com/pieroxy/lz-string).

## Installation

You can install the released version of lzstringr from
[CRAN](https://CRAN.R-project.org/package=lzstring) with:

``` r
install.packages("lzstring")
```

You can install the development version of lzstringr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("parmsam/lzstring-r")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(lzstring)

# text data
message = "The quick brown fox jumps over the lazy dog!";

compressed = lzstring::compressToBase64(message)
compressed
#> [1] "CoCwpgBAjgrglgYwNYQEYCcD2B3AdhAM0wA8IArGAWwAcBnCTANzHQgBdwIAbAQwC8AnhAAmmAOYBCIA"

decompressed = lzstring::decompressFromBase64(compressed)
cat(decompressed)
#> The quick brown fox jumps over the lazy dog!
```

### JSON data

``` r
# JSON data
json_data <- list(name = "John Doe", age = 30, email = "john.doe@example.com")
json_string <- jsonlite::toJSON(json_data)

compressed = lzstring::compressToBase64(json_string)
compressed
#> [1] "N4IgdghgtgpiBcBtEApA9gCzAAgCJrgF0AaECAcziQGYAGEkGKCASwBsFkArTMAOgAmBAAIwAHtAAObGHwDGaKCEIBfIA==="

decompressed = lzstring::decompressFromBase64(compressed)
identical(json_string, decompressed)
#> [1] FALSE
cat(decompressed)
#> {"name":["John Doe"],"age":[30],"email":["john.doe@example.com"]}
```

### R code

``` r
r_code <- '
library(dplyr)

data <- data.frame(
  name = c("John", "Jane", "Jake"),
  age = c(28, 22, 32),
  salary = c(50000, 60000, 55000)
)

# Filter data for age greater than 25
filtered_data <- filter(data, age > 25)

# Add a new column with updated salary
data <- mutate(data, updated_salary = salary * 1.05)
'
compressed = lzstring::compressToBase64(r_code)
compressed
#> [1] "FAGwlgRgTghlCeAKAJgBxPKBKYxkwBcYACAHgFpj8iA6AM1gFsBTRYY4gOxheIF5iAY0QAiAFIB7ABacRAGmLiYnZvMViYAa1VY57YjADmzfkMQAmABwLz5hQGZzu/QGcYIOPFPCArAAYAvwUANkCg4h9/AJwcYABiYgAxMBACZigqQhI6CQyjE0MoZkJ04gIpZWJzH2A6FLSi5AB9ahIKYjrU9JQshXziAD4qn1iEgEFkZAMuZgB3IQkQAFdGTmJZsHLiJdRqZim3DwQ8LLJKRiWiNJ6iBR295sPPUyeEYgAqYgBGGj8R4CAA=="
decompose = lzstring::decompressFromBase64(compressed)
cat(decompose)
#> 
#> library(dplyr)
#> 
#> data <- data.frame(
#>   name = c("John", "Jane", "Jake"),
#>   age = c(28, 22, 32),
#>   salary = c(50000, 60000, 55000)
#> )
#> 
#> # Filter data for age greater than 25
#> filtered_data <- filter(data, age > 25)
#> 
#> # Add a new column with updated salary
#> data <- mutate(data, updated_salary = salary * 1.05)
```

### Compress Shinylive Hashes

``` r
code <- 'library(shiny)
ui <- fluidPage(
  "Hello, world!"
)
server <- function(input, output, session) {
}
shinyApp(ui, server)'
files <- list(
  name = jsonlite::unbox("app.R"),
  content = jsonlite::unbox(code)
)
files_json <- jsonlite::toJSON(list(files))
files_lz <- lzstring::compressToEncodedURIComponent(as.character(files_json))
cat(paste0("https://shinylive.io/r/app/#code=", files_lz))
#> https://shinylive.io/r/app/#code=NobwRAdghgtgpmAXGKAHVA6ASmANGAYwHsIAXOMpMAGwEsAjAJykYE8AKAZwAtaJWAlAB0IAV1oACADwBaCQDNq4gCYAFKAHM47ERIlCwACTjVqRXBIDuRRtWUBCAyOEROcRgDd30ufNEQCUloSdj5UUVILIgjwyIk3Tk5giAEJEBEAXxEePlYAQXR2cQs3T3cBMAyAXSA
```

### Decompress Shinylive Hashes

``` r
x <- lzstring::decompressFromEncodedURIComponent("NobwRAdghgtgpmAXGKAHVA6VBPMAaMAYwHsIAXOcpMAMwCdiYACAZwAsBLCbDOAD1R04LFkw4xUxOmTERUAVzJ4mQiABM4dZfI4AdCPp0YuCsgH0WAGw4a6ACl2RHyxwDlnTAAzKAjJ+9MAEyeAJT64RAAAqq2GBR8ZPoaNExkCXYhiPpMOSpwZPJ0EEw0jhAAVIFioiAmihgQGUzlQQC+jvpgrQC6QA")
y <- jsonlite::fromJSON(x)
cat(y$name)
#> app.py
cat(y$content)
#> from shiny.express import input, render, ui
#> 
#> ui.input_slider("n", "N", 0, 100, 20)
#> 
#> 
#> @render.text
#> def txt():
#>     return f"n*2 is {input.n() * 2}"
```
