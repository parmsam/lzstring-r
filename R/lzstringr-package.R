## usethis namespace: start
#' @useDynLib lzstringr, .registration = TRUE
## usethis namespace: end
NULL

#' @export compressToBase64
compressToBase64 <- function(string) {
  string <- enc2utf8(string)
  compressToBase64_(string)
}

#' @export decompressFromBase64
decompressFromBase64 <- function(string) {
  string <- enc2utf8(string)
  decompressFromBase64_(string)
}

#' @export compressToEncodedURIComponent
compressToEncodedURIComponent <- function(string) {
  string <- enc2utf8(string)
  compressToEncodedURIComponent_(string)
}

#' @export decompressFromEncodedURIComponent
decompressFromEncodedURIComponent <- function(string) {
  string <- enc2utf8(string)
  decompressFromEncodedURIComponent_(string)
}
