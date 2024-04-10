## usethis namespace: start
#' @useDynLib lzstringr, .registration = TRUE
## usethis namespace: end
NULL

safe_compress <- function(string, f) {
  string <- enc2utf8(string)
  string <- iconv(string, from="UTF-8", to="UTF-16", toRaw=TRUE)[[1]]
  result <- f(string)
  chr_result <- rawToChar(as.raw(result))
  chr_result
}

safe_decompress <- function(string, f) {
  string <- enc2utf8(string)
  string <- iconv(string, from="UTF-8", to="UTF-16", toRaw=TRUE)[[1]]
  result <- f(string)
  chr_result <- intToUtf8(result)
  chr_result
}

#' @export compressToBase64
compressToBase64 <- function(string) {
  safe_compress(string, compressToBase64_)
}

#' @export decompressFromBase64
decompressFromBase64 <- function(string) {
  safe_decompress(string, decompressFromBase64_)
}

#' @export compressToEncodedURIComponent
compressToEncodedURIComponent <- function(string) {
  safe_compress(string, compressToEncodedURIComponent_)
}

#' @export decompressFromEncodedURIComponent
decompressFromEncodedURIComponent <- function(string) {
  safe_decompress(string, decompressFromEncodedURIComponent_)
}
