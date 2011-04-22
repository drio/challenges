#!/bin/bash
#
cat README |\
ruby -ne 'BEGIN{@h={}};\
@h[$1.chomp] = nil if $_ =~ /^http/ && $_.match(/embedCode=([\w_]+)[\&|\?|$]/) ;\
END{@h.each_key {|e| puts e} }'
