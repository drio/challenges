#!/usr/bin/env ruby
#
class StateMachine
  DEBUG = false
  def initialize(matrix)
    @m  = matrix               # matrix
    @cs = "start"              # current state: start, right, down, left, up, done
    @ap = []                   # already processed
    @cc = { :r => 0, :c => 0 } # current coordinate
    @nrows = @m.size; @ncols = @m[0].size
  end

  def move
    return false if @nrows == 0 && @ncols == 0
    @ap << cvalue
    unless @cs == "done"
      if DEBUG 
        printf "%s r:%s c:%s state:%s nr:%s nc:%s\n", 
          cvalue, @cc[:r], @cc[:c], @cs, @nrows, @ncols
      else 
        printf "%s ", cvalue
      end
    end 

    case @cs
      when /start|right/
        if right?
          @cc[:c] += 1; @cs = "right"
        elsif down?
          @cc[:r] += 1; @cs = "down"
        else
          @cs = "done"
        end
      when "down"
        if down?
          @cc[:r] += 1
        elsif left?
          @cc[:c] -= 1; @cs = "left"
        end
      when "left"
        if left?
          @cc[:c] -= 1
        elsif up?
          @cc[:r] -= 1; @cs = "up"
        else
          @cs = "done"
        end
      when "up"
        if up?
          @cc[:r] -= 1
        elsif right?
          @cc[:c] += 1; @cs = "right"
        else
          @cs = "done"
        end
      when "done"
        puts ""; return false
      else
        raise "We should not be here"
    end
    return true
  end

  private
  def right?
    in_already = still_columns?("+") ? include?(0,1) : false
    still_columns?("+") && !in_already
  end

  def down?
    in_already = still_rows?("+") ? include?(1,0) : false
    still_rows?("+") && !in_already
  end

  def left?
    in_already = still_columns?("-") ? include?(0,-1) : false
    still_columns?("-") && !in_already
  end

  def up?
    in_already = still_rows?("-") ? include?(-1,0) : false
    still_rows?("-") && !in_already
  end

  def still_columns?(o)
    o == "+" ? @cc[:c] + 1 < @ncols : @cc[:c] - 1 < @ncols
  end

  def still_rows?(o)
    o == "+" ? @cc[:r] + 1 < @nrows : @cc[:r] - 1 < @nrows
  end

  def cvalue # current_value
    @m[@cc[:r]][@cc[:c]]
  end

  def include?(r,c)
    @ap.include?(@m[@cc[:r]+r][@cc[:c]+c])
  end
end

#
# MAIN
m = []

#m = [[]]

#m << [1]

#m << [1, 2]

#m << [1 , 2 ]
#m << [4, 3 ]

#m << [1 , 2, 3 ]
#m << [8, 9, 4 ]
#m << [7, 6, 5 ]

#m << [1 , 2, 3, 4 ]
#m << [8 , 7, 6, 5 ]

#m << [1 ,2]
#m << [6 ,3]
#m << [5 ,4]

#m << [1 , 2, 3, 4 ]
#m << [10 , 11, 12, 5 ]
#m << [9 , 8, 7, 6 ]
#

m << [1  , 2 , 3 , 4 ]
m << [12 , 13, 14, 5 ]
m << [11 , 16, 15, 6 ]
m << [10 , 9 , 8 , 7 ]

sm = StateMachine.new(m)
while sm.move; end

