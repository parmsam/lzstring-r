## usethis namespace: start
#' @useDynLib lzstring, .registration = TRUE
## usethis namespace: end
NULL


# Helper function to convert string to UTF-16LE with BOM
convert_to_utf16le <- function(string) {
  string <- enc2utf8(string)
  string_utf16 <- iconv(string, from = "UTF-8", to = "UTF-16LE", toRaw = TRUE)[[1]]
  bom_le <- as.raw(c(0xFF, 0xFE))
  if (!identical(string_utf16[1:2], bom_le)) {
    string_utf16 <- c(bom_le, string_utf16)
  }
  string_utf16
}

decode_utf16_surrogate <- function(values) {
  # Estimate the maximum number of characters (since surrogate pairs condense to one character)
  max_chars <- length(values)
  decoded_chars <- character(max_chars)  # Pre-allocate with maximum possible size
  index <- 1  # Index to keep track of position in decoded_chars

  # Function to decode surrogate pairs
  decode_surrogates <- function(high, low) {
    code_point <- 0x10000 + (high - 0xD800) * 0x400 + (low - 0xDC00)
    intToUtf8(code_point)
  }

  i <- 1
  while (i <= length(values)) {
    if (values[i] < 0xD800 || values[i] > 0xDBFF) {
      # Not a high surrogate
      decoded_chars[index] <- intToUtf8(values[i])
      i <- i + 1
    } else {
      # Decode surrogate pairs
      if (i + 1 > length(values)) {
        stop("Malformed input: Surrogate high without a following low surrogate.")
      }
      decoded_chars[index] <- decode_surrogates(values[i], values[i + 1])
      i <- i + 2
    }
    index <- index + 1
  }

  # Truncate the vector to the actual number of characters decoded
  decoded_chars <- decoded_chars[1:(index - 1)]

  # Combine into a single string
  paste(decoded_chars, collapse = "")
}


safe_compress <- function(string, f) {
  string_utf16 <- convert_to_utf16le(string)
  result <- f(string_utf16)
  if (length(result) == 0) {
    return("")
  }
  chr_result <- rawToChar(as.raw(result))
  Encoding(chr_result) <- "UTF-8"
  chr_result
}

safe_decompress <- function(string, f) {
  string_utf16 <- convert_to_utf16le(string)
  result <- f(string_utf16)
  if (length(result) == 0) {
    return("")
  }
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
#' compressToBase64("Hello, world!")
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
#' x <- compressToBase64("Hello, world!")
#' decompressFromBase64(x)
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
#' compressToEncodedURIComponent("Hello, world!")
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
#' x <- compressToEncodedURIComponent("Hello, world!")
#' decompressFromEncodedURIComponent(x)
decompressFromEncodedURIComponent <- function(string) {
  stopifnot(
    "`string` must be a character." = is.character(string),
    "`string` must have length 1." = length(string) == 1
  )
  safe_decompress(string, decompressFromEncodedURIComponent_)
}
