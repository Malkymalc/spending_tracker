require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('controllers/budgets_controller')
require_relative('controllers/categories_controller')
require_relative('controllers/category_groups_controller')
require_relative('controllers/time_periods_controller')
require_relative('controllers/transactions_controller')
also_reload( '../models/*' )

get '/' do
  redirect to ("/spending-tracker")
end

get '/spending-tracker' do
  redirect to ("/spending-tracker/category-groups")
end
