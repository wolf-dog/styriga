function __styriga_strip_non_printable_chars --argument-names string
  echo (string replace --all --regex -- '(\x1b.*?[mGKH]|[\x00-\x1F\x7F])' '' $string)
end

