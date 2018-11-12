require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/add_controller')
require_relative('controllers/list_controller')
require_relative('controllers/show_controller')
require_relative('controllers/category_controller')
require_relative('controllers/budget_controller')

get '/' do
  redirect to ("/spending-tracker")
end

get '/spending-tracker' do
  redirect to ("/spending-tracker/add/new")
end
