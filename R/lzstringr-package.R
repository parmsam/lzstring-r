## usethis namespace: start
#' @useDynLib lzstringr, .registration = TRUE
## usethis namespace: end
NULL

#' @export compressToBase64
compressToBase64 <- function(string) {
  stopifnot(validUTF8(string))
  compressToBase64_(string)
}

#' @export decompressFromBase64
decompressFromBase64 <- function(string) {
  stopifnot(validUTF8(string))
  decompressFromBase64_(string)
}

#' @export compressToEncodedURIComponent
compressToEncodedURIComponent <- function(string) {
  stopifnot(validUTF8(string))
  compressToEncodedURIComponent_(string)
}

#' @export decompressFromEncodedURIComponent
decompressFromEncodedURIComponent <- function(string) {
  stopifnot(validUTF8(string))
  decompressFromEncodedURIComponent_(string)
}
