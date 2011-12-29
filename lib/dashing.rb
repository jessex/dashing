#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), 'dashing')

require 'configuration'
require 'dashboard'

require 'sinatra'
require 'active_support/all'

Dir[File.join(File.dirname(__FILE__), 'dashing', 'dash', '*.rb')].each { |file| require file }

set :views, settings.root + '/../views'
set :public_folder, File.dirname(__FILE__) + '/../public'

configuration = Configuration.load_configuration
dashboard = Dashboard::Board.new configuration
Dashboard.validate_layout dashboard

get '/dashboard' do
  erb :dashboard, :locals => { :board => dashboard }
end

dashboard.dashes.each do |dash|
  get "/dash/#{dash.name}" do
    locals = Object.const_get("#{dash.type.camelize}").send('get_erb_locals', dash.data)
    erb :"dashes/#{dash.type}", :locals => locals
  end
end
