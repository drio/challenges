#!/usr/bin/env lua

local h = {}
for line in io.stdin:lines() do
  for m in string.gmatch(line, "embedCode=([%a%d]+)") do 
    h[m] = 1
  end
end

for k,v in pairs(h) do print(k) end
