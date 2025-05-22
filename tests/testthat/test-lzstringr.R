## Utility function compress and decompress for comparison ----

compare_compress_decompress <- function(x) {
  compressed <- compressToBase64(x)
  decompressed <- decompressFromBase64(compressed)
  expect_equal(decompressed, x)
}

## Test cases originally from Python implementation ----

test_that("Compression to Base64 matches expected output", {
  s <- 'Žluťoučký kůň úpěl ďábelské ódy!'
  expected_base64 <- 'r6ABsK6KaAD2aLCADWBfgBPQ9oCAlAZAvgDobEARlB4QAEOAjAUxAGd4BL5AZ4BMBPAQiA=='

  expect_equal(compressToBase64(s), expected_base64)

  s <- 'aaaaabaaaaacaaaaadaaaaaeaaaaa'
  expected_base64 <- 'IYkI1EGNOATWBTWQ'

  expect_equal(compressToBase64(s), expected_base64)
})

test_that("Decompression from Base64 matches original string", {
  base64 <- 'r6ABsK6KaAD2aLCADWBfgBPQ9oCAlAZAvgDobEARlB4QAEOAjAUxAGd4BL5AZ4BMBPAQiA=='
  original_string <- 'Žluťoučký kůň úpěl ďábelské ódy!'

  expect_equal(decompressFromBase64(base64), original_string)

  base64 <- "CoCwpgBAjgrglgYwNYQEYCcD2B3AdhAM0wA8IArGAWwAcBnCTANzHQgBdwIAbAQwC8AnhAAmmAOZA"
  original_string <- "The quick brown fox jumps over the lazy dog"
  expect_equal(decompressFromBase64(base64), original_string)
})

test_that("Compression of JSON to Base64 matches expected output", {
  json_string <- '{"glossary":{"title":"example glossary","GlossDiv":{"title":"S","GlossList":{"GlossEntry":{"ID":"SGML","SortAs":"SGML","GlossTerm":"Standard Generalized Markup Language","Acronym":"SGML","Abbrev":"ISO 8879:1986","GlossDef":{"para":"A meta-markup language, used to create markup languages such as DocBook.","GlossSeeAlso":["GML","XML"]},"GlossSee":"markup"}}}}}'
  expected_base64_json <- 'N4Ig5gNg9gzjCGAnAniAXKALgS0xApuiPgB7wC2ADgQASSwIogA0IA4tHACLYBu6WXASIBlFu04wAMthiYBEhgFEAdpiYYQASS6i2AWSniRURJgCCMPYfEcGAFXyJyozPBUATJB5pt8Kp3gIbAAvfB99JABrAFdKGil3MBj4MEJWcwBjRCgVZBc0EBEDIwyAIzLEfH5CrREAeRoADiaAdgBONABGdqaANltJLnwAMwVKJHgicxpyfDcAWnJouJoIJJS05hoYmHCaTCgabPx4THxZlfj1lWTU/BgaGBjMgAsaeEeuKEyAISgoFEAHSDBgifD4cwQGBQdAAbXYNlYAA0bABdAC+rDscHBhEKy0QsUoIAxZLJQA'

  expect_equal(compressToBase64(json_string), expected_base64_json)
})

test_that("Decompression of Base64 JSON matches original JSON", {
  base64_json <- 'N4Ig5gNg9gzjCGAnAniAXKALgS0xApuiPgB7wC2ADgQASSwIogA0IA4tHACLYBu6WXASIBlFu04wAMthiYBEhgFEAdpiYYQASS6i2AWSniRURJgCCMPYfEcGAFXyJyozPBUATJB5pt8Kp3gIbAAvfB99JABrAFdKGil3MBj4MEJWcwBjRCgVZBc0EBEDIwyAIzLEfH5CrREAeRoADiaAdgBONABGdqaANltJLnwAMwVKJHgicxpyfDcAWnJouJoIJJS05hoYmHCaTCgabPx4THxZlfj1lWTU/BgaGBjMgAsaeEeuKEyAISgoFEAHSDBgifD4cwQGBQdAAbXYNlYAA0bABdAC+rDscHBhEKy0QsUoIAxZLJQA'
  original_json <- '{"glossary":{"title":"example glossary","GlossDiv":{"title":"S","GlossList":{"GlossEntry":{"ID":"SGML","SortAs":"SGML","GlossTerm":"Standard Generalized Markup Language","Acronym":"SGML","Abbrev":"ISO 8879:1986","GlossDef":{"para":"A meta-markup language, used to create markup languages such as DocBook.","GlossSeeAlso":["GML","XML"]},"GlossSee":"markup"}}}}}'

  decompressed_json <- decompressFromBase64(base64_json)
  expect_equal(decompressed_json, original_json)
})

## Test cases originally from original C++ implementation ----

test_that("compressToBase64 short string matches expected", {
  json <- '[{"n":"ps1.active","q":1,"t":1474356144455,"v":21}]'
  gold <- 'NobwRAdmBcYA4GcCMA6AhgYwC4EsBuApmADRgCOMSpWlALAOy0DMArAGxK1csul4wAmJAF8AukA='

  expect_equal(compressToBase64(json), gold)
})

test_that("compressToBase64 long string matches expected", {
  json <- "During tattooing, ink is injected into the skin, initiating an immune response, and cells called \"macrophages\" move into the area and \"eat up\" the ink. The macrophages carry some of the ink to the body's lymph nodes, but some that are filled with ink stay put, embedded in the skin. That's what makes the tattoo visible under the skin. Dalhousie Uiversity's Alec Falkenham is developing a topical cream that works by targeting the macrophages that have remained at the site of the tattoo. New macrophages move in to consume the previously pigment-filled macrophages and then migrate to the lymph nodes, eventually taking all the dye with them. \"When comparing it to laser-based tattoo removal, in which you see the burns, the scarring, the blisters, in this case, we've designed a drug that doesn't really have much off-target effect,\" he said. \"We're not targeting any of the normal skin cells, so you won't see a lot of inflammation. In fact, based on the process that we're actually using, we don't think there will be any inflammation at all and it would actually be anti-inflammatory."

  gold <- "CIVwTglgdg5gBAFwIYIQezdGAaO0DWeAznlAFYCmAxghQCanqIAWFcR+0u0ECEKWOEih4AtqJBQ2YCkQAOaKEQq5hDKhQA2mklSTb6cAESikVMGjnMkMWUbii0ANzbQmCVkJlIhUBkYoUOBA5ew9XKHwAOjgAFU9Tc0trW10kMDAAT3Y0UTY0ADMWCMJ3TwAjNDpMgHISTUzRKzgoKtlccpAEHLyWIPS2AogDBgB3XmZSQiJkbLku3ApRcvo6Q2hi9k4oGPiUOrhR627TfFlN5FQMOCcIIghyzTZJNbBNjmgY4H1mNBB7tgAVQgLjA9wQtRIAEEnlQ4AAxfRnKDWUTEOBrFyaSyCHzoOQQPSaODmQJojxBUZoMD4EjlbLIMC2PiwTaJCxWGznCndawuOAyUzQQxBcLsXj5Ipiy7oNAxAByFFGDjMHJS50c/I2TCoiiIIF6YrkMlufyIDTgBJgeSgCAAtEMRiqkpzUr4GOERKIIDAwCg2GU2A0mpNWmsiIsXLaQPoLchtvBY5tqmxxh5iqIYkYAOqsES6prpQS8RBoOCaJDKMB28qVwwy66C5z6bgiI6EyaZP7sCgBirgJS4MVEPQZLBDiqaO60MGtlh3El13CjCg1fnhn1SBg+OhgEDwHkYtCyKA1brebTZPlsCRUSaFAp2xnMuAUAoFagIbD2TxEJAQOgs2zVcZBaNBumfCgWUTKBskKTZWjAUxiQ+fMtB0XAiDLLsQEORQzx7NgfGxbp4OgAoK3EARFBiABJEQCjML84FrZQGEUTZjTQDQiBIQ8VxqUCmJjS9gnuWBlzYOh8Ig5gCGKUDxm0FiiNg0gKKQKi+A4/plLUPBuipEBNG3GgRItFZfD4O1yMo0x0CyKIgA"
  compressed <- compressToBase64(json)

  expect_equal(compressed, gold)
})

test_that("compressToBase64 with UTF-8 input matches expected", {
  text <- "UTF-8 middle dot '·'. Random text ĤϜPՌ"
  gold <- "KoFQYgtAHABAtgSwCZIDYFMZIPYBcYDkA7QQHQwBKAhgHY5wy7oAe+gJICA7wAAqAyoEA==="

  expect_equal(compressToBase64(text), gold)
})

test_that("decompressFromBase64 returns original JSON", {
  json <- '[{"n":"ps1.active","q":1,"t":1474356144455,"v":21}]'
  compressed <- compressToBase64(json)
  uncompressed <- decompressFromBase64(compressed)

  expect_equal(uncompressed, json)
})

test_that("decompressFromBase64 with UTF-8 input returns original text", {
  text <- "UTF-8 middle dot '·'. Random text ĤϜPՌ"
  compressed <- compressToBase64(text)
  uncompressed <- decompressFromBase64(compressed)

  expect_equal(uncompressed, text)
})

test_that("Compression to Base64 compared to JavaScript implementation", {
  json <- '[{"foo":42},{"pi":3.14},"long dash symbol":"—"]'
  compressed <- compressToBase64(json)
  gold <- 'NobwRAZg9lYFwBYBMBfANOADgS3gZgDoBGBdMAGygDsBzAAgBMBDAZwAs6WBPAWwCMo5eGEAoBGAC6QA'

  expect_equal(compressed, gold)
})

test_that("Decompression from Base64 matches JavaScript implementation output", {
  fromJS <- 'NobwRAZg9lYFwBYBMBfANOADgS3gZgDoBGBdMAGygDsBzAAgBMBDAZwAs6WBPAWwCMo5eGEAoBGAC6QA'
  uncompressed <- decompressFromBase64(fromJS)

  expect_equal(uncompressed, '[{"foo":42},{"pi":3.14},"long dash symbol":"—"]')
})

## Test cases to ensure the string is UTF-8 encoded ----

test_that("Ensure strings are UTF-8 encoded", {

  x <- "fa\xE7ile"
  Encoding(x) <- "latin1"

  expect_no_error(compressToBase64(x))
  expect_no_error(compressToEncodedURIComponent(x))

  y <- decompressFromBase64(compressToBase64(x))
  expect_equal(Encoding(y), "UTF-8")

  x <- "한 글"
  Encoding(x) <- "unknown"

  expect_no_error(compressToBase64(x))
  expect_no_error(compressToEncodedURIComponent(x))

  y <- decompressFromBase64(compressToBase64(x))
  expect_equal(Encoding(y), "UTF-8")
})

## Test cases for difference encodings ----

test_that("Compress and Decompress for different encodings", {
  emoji_pat <- 	"😑😑 😑"
  compare_compress_decompress(emoji_pat)

  pat <- rawToChar(as.raw(c(0xce, 0x94, 0xe2, 0x98, 0x85, 0xf0, 0x9f, 0x98, 0x8e)))
  Encoding(pat) <- "UTF-8"
  compare_compress_decompress(pat)

  x <- rawToChar(as.raw(c(0xe5, 0x8d, 0x88)))
  Encoding(x) <- "UTF-8"
  compare_compress_decompress(x)

  latin1_str <- rawToChar(as.raw(0xFF))
  Encoding(latin1_str) <- "latin1"
  compare_compress_decompress(latin1_str)

  japanese_text <- "こんにちは"  # Hello in Japanese
  encoded_text <- iconv(japanese_text, from = "UTF-8", to = "Shift-JIS")
  decoded_text <- iconv(encoded_text, from = "Shift-JIS", to = "UTF-8")
  compressed <- compressToBase64(decoded_text)
  decompressed <- decompressFromBase64(compressed)
  expect_equal(decompressed, japanese_text)
})

test_that("Compression handles special characters and symbols", {
  text <- "𐐷𐑌 – Mathematical symbols: ∑ ∫, Emoji: 😊, Arabic: العربية, Hebrew: עברית"
  expect_no_error(compressToBase64(text))
  compare_compress_decompress(text)
  text <- "漢字 – Kanji, Cyrillic: Цирилица, Thai: ภาษาไทย"
  expected <- "kT2nVtAEjIBGDSCGB2ArAlgGjAYQJ4CdkBt9kBjALjEDIQQDhBABECsG4QKwMRBAGEHQBUALWZcwAjhATHCBKOAGAROEDocICI4IA==="
  expect_no_error(compressToBase64(text))
  compare_compress_decompress(text)
  expect_equal(compressToBase64(text), expected)
})

test_that("Decompression handles malformed input gracefully", {
  malformed_base64 <- "This isn't base64 at all!"
  # Decompression should handle this without crashing
  expect_no_error(decompressFromBase64(malformed_base64))
  expect_equal(decompressFromBase64(malformed_base64), "")
})


## Test cases for specific operating systems ----

test_that("Compression handles OS-specific encodings", {
  skip()
  input_windows <- iconv("This is a test – with a dash", from = "UTF-8", to = "Windows-1252")
  input_mac <- iconv("This is a test – with a dash", from = "UTF-8", to = "macintosh")
  compressToBase64(input_windows)
  compare_compress_decompress(input_windows)
  compare_compress_decompress(input_mac)
})

# Test cases to URI component compression ----

test_that("Compress to URI component", {
  text <- "aaaaabaaaaacaaaaadaaaaaeaaaaa"
  compressed <- compressToEncodedURIComponent(text)
  expected <- "IYkI1EGNOATWBTWQ"
  expect_equal(compressed, expected)
})

# Test cases for to and from URI component encoding ----

test_that("Compress and Decompress for URI encoding", {
  text <- "[{\"name\":\"app.py\",\"content\":\"from shiny.express import input, render, ui\\n\\nui.input_slider(\\\"n\\\", \\\"N\\\", 0, 100, 20)\\n\\n\\n@render.text\\ndef txt():\\n    return f\\\"n*2 is {input.n() * 2}\\\"\\n\"}]"
  hash <- "NobwRAdghgtgpmAXGKAHVA6VBPMAaMAYwHsIAXOcpMAMwCdiYACAZwAsBLCbDOAD1R04LFkw4xUxOmTERUAVzJ4mQiABM4dZfI4AdCPp0YuCsgH0WAGw4a6ACl2RHyxwDlnTAAzKAjJ+9MAEyeAJT64RAAAqq2GBR8ZPoaNExkCXYhiPpMOSpwZPJ0EEw0jhAAVIFioiAmihgQGUzlQQC+jvpgrQC6QA"

  compressed <- compressToEncodedURIComponent(text)
  expect_equal(compressed, hash)

  decompressed <- decompressFromEncodedURIComponent(compressed)
  expect_equal(decompressed, text)
})

# Test case for repeated ----

test_that('"abcd", but longer (128 of each character).',{
  repeated <- readLines("resources/repeated.txt")
  compare_compress_decompress(repeated)
})

# Test case for 10,000 digits of pi ----

test_that("Many digits of pi",{
  pi10k <- readLines("resources/pi.txt")
  # limit to the first 4054 characters
  pi10k <- paste0(pi10k, collapse = "")
  expect_no_error(compressToBase64(pi10k))
  compare_compress_decompress(pi10k)
})

# Test case for lorem ipsum ----

test_that("Lorem ipsum text",{
  lorem <- readLines("resources/lorem.txt")
  lorem <- paste0(lorem, collapse = "\n")
  expect_no_error(compressToBase64(lorem))
  compare_compress_decompress(lorem)
})

# Test case for orbit Shiny for Python app ----

test_that("Orbit Shiny for Python app",{
  orbit <- readLines("resources/orbit-app-uri.txt")
  x <- decompressFromEncodedURIComponent(orbit)
  expect_true(grepl("app.py", substr(x, 1, 20)))
})

# Test case for many new lines ----

test_that("String with a bunch of new lines",{
x <- "
1
A


500
"
  compare_compress_decompress(x)
})

# Test cases for complex JSON ----

test_that("compressToEncodedURIComponent round-trips complex JSON", {
  stable_full <- list(
    list(version = 1, class = "ellmer::Turn", props = list(
      role = "user",
      contents = list(list(version = 1, class = "ellmer::ContentText", props = list(text = "a"))),
      tokens = c(0, 0)
    )),
    list(version = 1, class = "ellmer::Turn", props = list(
      role = "assistant",
      contents = list(list(version = 1, class = "ellmer::ContentText", props = list(
        text = "There once was a lady by the river,\nWhose heart was full,\nWho spent her days looking up so,\nAnd day after day she grew.\n\nShe found delight in every turn of view,\nHer eyes wide open wide,\nSo that whenever time seemed long, dear friend,\nYou could trust she'd return."
      ))),
      tokens = c(23L, 63L)
    )),
    list(version = 1, class = "ellmer::Turn", props = list(
      role = "user",
      contents = list(list(version = 1, class = "ellmer::ContentText", props = list(text = "b"))),
      tokens = c(0, 0)
    )),
    list(version = 1, class = "ellmer::Turn", props = list(
      role = "assistant",
      contents = list(list(version = 1, class = "ellmer::ContentText", props = list(
        text = "In the land where love does run wild,\nThere was a lover who didn't care,\nWho believed he would find,\nAnd all the while he searched.\n\nHe spent his days looking for just one girl,\nHis thoughts were pure and clear,\nSo that every year he dreamed,\nOf her presence in the air."
      ))),
      tokens = c(96L, 63L)
    ))
  )
  json <- jsonlite::serializeJSON(stable_full)
  compressed <- lzstring::compressToEncodedURIComponent(json)
  decompressed <- lzstring::decompressFromEncodedURIComponent(compressed)
  result <- jsonlite::unserializeJSON(decompressed)
  expect_equal(stable_full, result)
})

test_that("compressToEncodedURIComponent round trips intermediate JSON (to_empty_string)", {
  stable <- list(
    list(version = 1, class = "ellmer::Turn", props = list(
      role = "user",
      contents = list(list(version = 1, class = "ellmer::ContentText", props = list(text = "a"))),
      tokens = c(0, 0)
    )),
    list(version = 1, class = "ellmer::Turn", props = list(
      role = "assistant",
      contents = list(list(version = 1, class = "ellmer::ContentText", props = "She found delight in every turn of view,Her eyes wide open wide,So that whenever time seemed long, dear friend,You could trust she'd return.")),
      tokens = c(23L, 63L)
    ))
  )
  json <- jsonlite::serializeJSON(stable)
  compressed <- lzstring::compressToEncodedURIComponent(json)
  decompressed <- lzstring::decompressFromEncodedURIComponent(compressed)
  result <- jsonlite::unserializeJSON(decompressed)
  expect_equal(stable, result)
})

test_that("compressToEncodedURIComponent round-trips simple JSON", {
  stable <- list(
    list(version = 1, class = "ellmer::Turn", props = list(
      role = "user",
      contents = list(list(version = 1, class = "ellmer::ContentText", props = list(text = "a"))),
      tokens = c(0, 0)
    ))
  )
  json <- jsonlite::serializeJSON(stable)
  compressed <- lzstring::compressToEncodedURIComponent(json)
  decompressed <- lzstring::decompressFromEncodedURIComponent(compressed)
  result <- jsonlite::unserializeJSON(decompressed)
  expect_equal(stable, result)
})
