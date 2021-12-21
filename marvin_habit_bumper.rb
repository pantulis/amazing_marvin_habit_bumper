require 'sinatra/base'
require './lib/marvin/marvin.rb'

class MarvinHabitBumper < Sinatra::Base

  set :default_content_type, :json
  
  get '/habits/get/:habit_id' do

    res = MarvinAPI::get_habit(params['habit_id'])
  end

  get '/habits/bump/:habit_id' do
    res = MarvinAPI::bump_habit(params['habit_id'])
  end

end

