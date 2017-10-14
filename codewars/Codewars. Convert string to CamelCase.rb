def to_camel_case(str)
  str.gsub(/[_-](?<letter>.)/) { $~[:letter].upcase }
end

def to_camel_case(str)
  str.gsub(/[_-](.)/) { Regexp.last_match(1).upcase }
end

def to_camel_case(str)
  str.gsub(/[_-](.)/) { $1.upcase }
end

def to_camel_case(str)
  head, *tail = str.split(/[-_]/)
  head + tail.map(&:capitalize).join
end
