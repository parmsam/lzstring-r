## Test cases originally from Python implementation ----

test_that("Compression to Base64 matches expected output", {
  s <- 'Žluťoučký kůň úpěl ďábelské ódy!'
  expected_base64 <- 'r6ABsK6KaAD2aLCADWBfgBPQ9oCAlAZAvgDobEARlB4QAEOAjAUxAGd4BL5AZ4BMBPAQiA=='

  expect_equal(compressToBase64(s), expected_base64)
})

test_that("Decompression from Base64 matches original string", {
  base64 <- 'r6ABsK6KaAD2aLCADWBfgBPQ9oCAlAZAvgDobEARlB4QAEOAjAUxAGd4BL5AZ4BMBPAQiA=='
  original_string <- 'Žluťoučký kůň úpěl ďábelské ódy!'

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

test_that("Non UTF-8 characters return error", {
  x <- c("Jetz", "no", "chli", "z\xc3\xbcrit\xc3\xbc\xc3\xbctsch:", "(noch", "ein", "bi\xc3\x9fchen", "Z\xc3\xbc", "deutsch)", "\xfa\xb4\xbf\xbf\x9f")

  expect_error(compressToBase64(x))
  expect_error(compressToEncodedURIComponent(x))
})
