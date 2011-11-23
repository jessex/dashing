#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib', 'dashing')

require 'configuration'
require 'dashboard'

Dir[File.join(File.dirname(__FILE__), 'dashing', 'dash')].each { |file| require file }

configuration = Configuration.load_configuration
dashboard = Dashboard::Board.new configuration
Dashboard.validate_layout dashboard
