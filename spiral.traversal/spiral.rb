#!/usr/bin/env ruby
#
class StateMachine
  def initialize(nrows, ncols, matrix)
    @m  = matrix # matrix
    @cs = "start" # current state: start, right, down, left, up, done
    @ap = []      # already processed
    @cc = { :r => 0, :c => 0 } # current coordinate
    @nrows = nrows; @nrows = ncols
  end

  def move(current)
    @ap << current_value
    case cs
      when "start" # to done or right
        @cc[:c] += 1 if right?
      else
        raise "We should not be here"
      end
  end

  private
  # I can move to the right if there are more columns
  # and I have not processed the element in the next position
  def right? 
    still_columns = @cc[:c] + 1 < @ncols
    in_already = still_columns ?
                 !@ap.include?(@m[@cc[:r]][@cc[:c]+1]) :
                 false
    still_columns && !in_already
  end

  def current_value
    @m[@cc[:r]][@cc[:c]]
  end
end


m = []
m << [1 , 2, 3 ]
m << [10, 11, 12 ]
m << [9, 8, 7 ]


