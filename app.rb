# frozen_string_literal: true

require 'bundler'
Bundler.require

$LOAD_PATH.unshift File.expand_path('lib', __dir__)

require 'app/cells'
require 'app/grid'
require 'app/players'
require 'views/launcher'

# Some consts to get things prettier
PROMPT = '> '
SPACER = "\n"
RULER = '░' * 60
SEPARATOR = (SPACER + RULER + SPACER + SPACER).green

Launcher.new

# binding.pry
