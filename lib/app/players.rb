# frozen_string_literal: true

# This class generate the players
class Players
  attr_accessor :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end
