require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('controllers/add_controller')
require_relative('controllers/list_controller')
require_relative('controllers/show_controller')
require_relative('controllers/category_controller')
require_relative('controllers/budget_controller')
also_reload( '../models/*' )


get '/spending-tracker/add/new' do
  @category_groups = CategoryGroup.all()
  @categories = Category.all()
  @time_periods = TimePeriod.all()
  erb(:"add/new")
end

post '/spending-tracker/add' do
  transaction = Transaction.new( params )
  transaction.save()
  #confirmation page?
  redirect to  ("/spending-tracker/add/new")
end
