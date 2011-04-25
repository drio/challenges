#!/usr/bin/env ruby
#

h = {}
ARGF.each_line do |l|
  h[$1.chomp] = nil if l =~ /^http/ && l.match(/embedCode=([\w_]+)[\&|\?|$]/)
end

h.each_key {|e| puts e}
