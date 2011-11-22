#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '../lib/dashing')

require 'dashboard'
require 'YAML'

CONFIG_FILE = 'data/config.yml'
CONFIGURATION = YAML::load_file(CONFIG_FILE)

dashboard = Dashboard::Board.new CONFIGURATION
