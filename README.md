
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lzstringr

<!-- badges: start -->
<!-- badges: end -->

The goal of lzstringr is to provide an R wrapper for the [lzstring C++
library](https://github.com/andykras/lz-string-cpp). lzstring is a
JavaScript library that provides fast and efficient string compression
and decompression. Credit goes to Winston Chang for spotting this
missing R package and doing a 90% of the work over at the Shinylive
repo—check out his awesome contributions which this repo is based on
[here](https://github.com/posit-dev/r-shinylive/issues/70) and
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

compressed = lzstringr:::compressToBase64(data)
compressed
#> [1] "CoCwpgBAjgrglgYwNYQEYCcD2B3AdhAM0wA8IArGAWwAcBnCTANzHQgBdwIAbAQwC8AnhAAmmAOYBCIA"

decompressed = lzstringr:::decompressFromBase64(compressed)
decompressed
#> [1] "The quick brown fox jumps over the lazy dog!"
```
