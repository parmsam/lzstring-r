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

#' Compress a string to Base64
#'
#' This function takes a string as input and returns a compressed version of the string in Base64 format.
#'
#' @param string A character string to be compressed.
#' @return A character string representing the compressed input string in Base64 format.
#' @export
#' @examples
#' \dontrun{
#' compressToBase64("Hello, world!")
#' }
compressToBase64 <- function(string) {
  safe_compress(string, compressToBase64_)
}

#' Decompress a string from Base64
#'
#' This function takes a compressed string in Base64 format as input and returns the decompressed version of the string.
#'
#' @param string A character string in Base64 format to be decompressed.
#' @return A character string representing the decompressed input string.
#' @export
#' @examples
#' \dontrun{
#' decompressFromBase64(compressed_string)
#' }
decompressFromBase64 <- function(string) {
  safe_decompress(string, decompressFromBase64_)
}

#' Compress a string to Encoded URI Component
#'
#' This function takes a string as input and returns a compressed version of the string in Encoded URI Component format.
#'
#' @param string A character string to be compressed.
#' @return A character string representing the compressed input string in Encoded URI Component format.
#' @export
#' @examples
#' \dontrun{
#' compressToEncodedURIComponent("Hello, world!")
#' }
compressToEncodedURIComponent <- function(string) {
  safe_compress(string, compressToEncodedURIComponent_)
}

#' Decompress a string from Encoded URI Component
#'
#' This function takes a compressed string in Encoded URI Component format as input and returns the decompressed version of the string.
#'
#' @param string A character string in Encoded URI Component format to be decompressed.
#' @return A character string representing the decompressed input string.
#' @export
#' @examples
#' \dontrun{
#' decompressFromEncodedURIComponent(compressed_string)
#' }
decompressFromEncodedURIComponent <- function(string) {
  safe_decompress(string, decompressFromEncodedURIComponent_)
}
