#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), 'dashing')

require 'configuration'
require 'dashboard'
require 'sinatra'

Dir[File.join(File.dirname(__FILE__), 'dashing', 'dash')].each { |file| require file }

set :views, settings.root + '/../views'
set :public_folder, File.dirname(__FILE__) + '/../public'

configuration = Configuration.load_configuration
dashboard = Dashboard::Board.new configuration
Dashboard.validate_layout dashboard

get '/dashboard' do
  erb :dashboard, :locals => { :board => dashboard }
end
