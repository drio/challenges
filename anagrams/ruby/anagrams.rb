#!/usr/bin/env ruby
#
module Challenges
  def self.is_anagram?(o, t)  
    return false if o.size != t.size
    so, st = o.split('').sort, t.split('').sort  
    (0..so.size-1).each {|i| return false if so[i] != st[i]  }
    true
  end
end

if ! $test
  if __FILE__ == $0
    # Main
    (puts "Usage: #{__FILE__} <word> <word>"; exit 1) if ARGV.size != 2  
    is_or_not = Challenges::is_anagram?(ARGV[0], ARGV[1]) ? "YES" : "NO"
    puts is_or_not
  end
else
 require 'test/unit'
  class TestSimple < Test::Unit::TestCase
    def test_anagram
      o = "this"
      t = "shit"
      assert_equal(true, Challenges::is_anagram?(o, t))
      t = "shitx"
      assert_equal(false, Challenges::is_anagram?(o, t))
      o = "xxx"; t = "yyy"
      assert_equal(false, Challenges::is_anagram?(o, t))
    end
  end
end
