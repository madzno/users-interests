require 'yaml'

require 'tilt/erubis'
require 'sinatra'
require 'sinatra/reloader'

before do
  @users = YAML.load_file('users.yml')
end

helpers do
  def count_interests
    interests_counts = []

    @users.values.each { |hash| interests_counts << (hash[:interests].count) }

   interests_counts.sum
  end
end

get '/' do

  @names = []
  @users.each_key { |key| @names << key }

  erb :home
end

get '/:name' do
  @user_name = params[:name].to_sym
  @email = @users[@user_name][:email]
  @interests = @users[@user_name][:interests].join(', ')

  @other_names = @users.keys.select { |other_user| other_user != @name }

  erb :user_page
end
