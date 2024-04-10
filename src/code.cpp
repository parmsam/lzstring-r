#include <cpp11.hpp>
using namespace cpp11;
#include <codecvt>
#include "lz-string.hpp"
#include <string>
#include <vector>
#include <iostream>

std::u16string createUTF16String(const std::vector<unsigned char>& bytes) {
  if (bytes.size() < 2) {
    throw std::runtime_error("Invalid byte array. Size must be at least 2 bytes.");
  }

  // Check byte order mark (BOM)
  bool isLittleEndian = (bytes[0] == 0xFF && bytes[1] == 0xFE);
  bool isBigEndian = (bytes[0] == 0xFE && bytes[1] == 0xFF);

  if (!isLittleEndian && !isBigEndian) {
    throw std::runtime_error("Invalid byte order mark (BOM).");
  }

  std::u16string result;
  for (size_t i = 2; i < bytes.size(); i += 2) {
    char16_t codeUnit;
    if (isLittleEndian) {
      codeUnit = static_cast<char16_t>(bytes[i] | (bytes[i + 1] << 8));
    } else {
      codeUnit = static_cast<char16_t>((bytes[i] << 8) | bytes[i + 1]);
    }
    result.push_back(codeUnit);
  }

  return result;
}


[[cpp11::register]]
std::u16string compressToEncodedURIComponent_(std::vector<unsigned char> bytes) {
  std::u16string uncompressed16 = createUTF16String(bytes);

  auto compressed16 = lzstring::compressToEncodedURIComponent(uncompressed16);

  return compressed16;
}


[[cpp11::register]]
std::u16string decompressFromEncodedURIComponent_(std::vector<unsigned char> bytes) {
  std::u16string compressed16 = createUTF16String(bytes);

  auto uncompressed16 = lzstring::decompressFromEncodedURIComponent(compressed16);

  return uncompressed16;
}

[[cpp11::register]]
std::u16string compressToBase64_(std::vector<unsigned char> bytes) {
  std::u16string uncompressed16 = createUTF16String(bytes);

  auto compressed16 = lzstring::compressToBase64(uncompressed16);

  return compressed16;
}

[[cpp11::register]]
std::u16string decompressFromBase64_(std::vector<unsigned char> bytes) {
  std::u16string compressed16 = createUTF16String(bytes);

  auto uncompressed16 = lzstring::decompressFromBase64(compressed16);

  return uncompressed16;
}
