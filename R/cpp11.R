# Generated by cpp11: do not edit by hand

compressToEncodedURIComponent_ <- function(bytes) {
  .Call(`_lzstring_compressToEncodedURIComponent_`, bytes)
}

decompressFromEncodedURIComponent_ <- function(bytes) {
  .Call(`_lzstring_decompressFromEncodedURIComponent_`, bytes)
}

compressToBase64_ <- function(bytes) {
  .Call(`_lzstring_compressToBase64_`, bytes)
}

decompressFromBase64_ <- function(bytes) {
  .Call(`_lzstring_decompressFromBase64_`, bytes)
}
