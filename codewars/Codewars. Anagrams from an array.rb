# a '1 liner'

def anagrams(word, words)
  word = word.chars.sort
  words.select { |w| w.chars.sort == word }
end

p anagrams("mate", ["sasd", "sada", "dfF", "etam"]) # => ["etam"]

# using a hash
def anagrams(word, words)
  target_count = Hash.new(0)
  word.each_char { |ch| target_count[ch] += 1 }

  words.reduce([]) do |anagrams, word|
    count = Hash.new(0)
    word.each_char { |ch| count[ch] += 1 }
    count == target_count ? anagrams << word : anagrams
  end
end

p anagrams("mate", ["sasd", "sada", "dfF", "etam"]) # => ["etam"]

# `keep_if` and `select!` behave the same way
def anagrams(word, words)
  check = word.chars.sort
  # words.keep_if { |wd| wd.chars.sort == check }
  words.select! { |wd| wd.chars.sort == check }
end

# if using `each_with_object`, note it has a different order from `reduce`

p anagrams("mate", ["sasd", "sada", "dfF", "etam"]) # => ["etam"]
