require 'tilt/erubis'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml'

get '/' do
  users = YAML.load_file('users.yml')

  @names = []

  users.each_key { |key| @names << key }

  erb :home
end

get '/:name' do
  users = YAML.load_file('users.yml')
  name = params[:name].to_sym

  users_info = users[name]

  @email = users_info[:email]
  @interests = users_info[:interests]

  erb :name
end
