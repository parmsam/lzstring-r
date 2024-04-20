## usethis namespace: start
#' @useDynLib lzstring, .registration = TRUE
## usethis namespace: end
NULL

decode_utf16_surrogate <- function(values) {
  # Initialize an empty character vector to store decoded characters
  decoded_chars <- character()
  # Function to decode surrogate pairs
  decode_surrogates <- function(high, low) {
    # Calculate the Unicode code point from surrogate values
    # Formula: 0x10000 + (high - 0xD800) * 0x400 + (low - 0xDC00)
    code_point <- 0x10000 + (high - 0xD800) * 0x400 + (low - 0xDC00)
    # Convert the Unicode code point to a character
    intToUtf8(code_point)
  }
  i <- 1
  while (i <= length(values)) {
    if (values[i] < 0xD800 ||
      values[i] > 0xDBFF) {
      # Not a high surrogate
      # Direct conversion for regular characters (like space)
      decoded_chars <- c(decoded_chars, intToUtf8(values[i]))
      i <- i + 1
    } else {
      # Decode surrogate pairs
      decoded_chars <-
        c(decoded_chars, decode_surrogates(values[i], values[i + 1]))
      i <- i + 2
    }
  }
  # Combine into a single string
  paste(decoded_chars, collapse = "")
}

safe_compress <- function(string, f) {
  string <- enc2utf8(string)
  string_utf16 <-
    iconv(string,
      from = "UTF-8",
      to = "UTF-16LE",
      toRaw = TRUE
    )[[1]]
  bom_le <- charToRaw("\xFF\xFE")
  if (!identical(string_utf16[1:2], bom_le)) {
    string_utf16 <- c(bom_le, string_utf16)
  }
  result <- f(string_utf16)
  chr_result <- rawToChar(as.raw(result))
  Encoding(chr_result) <- "UTF-8"
  chr_result
}

safe_decompress <- function(string, f) {
  string <- enc2utf8(string)
  string_utf16 <-
    iconv(string,
      from = "UTF-8",
      to = "UTF-16LE",
      toRaw = TRUE
    )[[1]]
  bom_le <- charToRaw("\xFF\xFE")
  if (!identical(string_utf16[1:2], bom_le)) {
    string_utf16 <- c(bom_le, string_utf16)
  }
  result <- f(string_utf16)
  chr_result <- decode_utf16_surrogate(result)
  Encoding(chr_result) <- "UTF-8"
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
  stopifnot(
    "`string` must be a character." = is.character(string),
    "`string` must have length 1." = length(string) == 1
  )
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
  stopifnot(
    "`string` must be a character." = is.character(string),
    "`string` must have length 1." = length(string) == 1
  )
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
  stopifnot(
    "`string` must be a character." = is.character(string),
    "`string` must have length 1." = length(string) == 1
  )
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
  stopifnot(
    "`string` must be a character." = is.character(string),
    "`string` must have length 1." = length(string) == 1
  )
  safe_decompress(string, decompressFromEncodedURIComponent_)
}
