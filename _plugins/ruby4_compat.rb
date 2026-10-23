# Compatibility patch for Jekyll 4.x on Ruby 4.0+ when static filenames contain UTF-8 bytes
module Jekyll
  class URL
    def self.unescape_path(path)
      path = path.dup.force_encoding(Encoding::UTF_8) if path.encoding == Encoding::ASCII_8BIT
      path = path.encode("utf-8")
      return path unless path.include?("%")

      Addressable::URI.unencode(path)
    end
  end
end
