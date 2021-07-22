# frozen_string_literal: true

# This class handle the status of a given cell in the grid.
class Cells
  attr_accessor :cell, :state

  def initialize(place, state)
    @cell = place
    @state = state
  end
end
