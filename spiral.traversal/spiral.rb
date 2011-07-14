#!/usr/bin/env ruby
#
class StateMachine
  def initialize(matrix)
    @m  = matrix               # matrix
    @cs = "start"              # current state: start, right, down, left, up, done
    @ap = []                   # already processed
    @cc = { :r => 0, :c => 0 } # current coordinate
    @nrows = @m.size-1; @ncols = @m.size-1
  end

  def move(current)
    @ap << current_value
    print unless @cs == "done"
    case cs
      when "start"
      when "right"
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
          @cc[c] += 1; @cs = "right"
        else
          @cs = "done"
        end
      when "done"
        return false
      else
        raise "We should not be here"
    end
    return true
  end

  private
  def print
    printf "%s ", current_value
  end

  # I can move to the right if there are more columns
  # and I have not processed the element in the next position
  def right?
    in_already = still_columns("+") ? @ap.include?(@m[@cc[:r]][@cc[:c]+1]) : false
    still_columns?("+") && !in_already
  end

  def down?
    in_already = still_rows("+") ? @ap.include?(@m[@cc[:r]+1][@cc[:c]]) : false
    still_rows?("+") && !in_already
  end

  def left?
    in_already = still_columns("-") ? @ap.include?(@m[@cc[:r]][@cc[:c]-1]) : false
    still_columns?("-") && !in_already
  end

  def up?
    in_already = still_rows("-") ? @ap.include?(@m[@cc[:r]-1][@cc[:c]]) : false
    still_rows?("-") && !in_already
  end

  def still_columns?(o)
    o == "+" ? @cc[:c] + 1 < @ncols : @cc[:c] - 1 < @ncols
  end

  def still_rows?(o)
    o == "+" ? @cc[:r] + 1 < @nrows : @cc[:r] - 1 < @nrows
  end

  def current_value
    @m[@cc[:r]][@cc[:c]]
  end
end

m = []
m << [1 , 2, 3 ]
m << [10, 11, 12 ]
m << [9, 8, 7 ]


