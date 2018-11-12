require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('controllers/add_controller')
require_relative('controllers/list_controller')
require_relative('controllers/show_controller')
require_relative('controllers/category_controller')
require_relative('controllers/budget_controller')
also_reload( '../models/*' )

get '/spending-tracker/list/all' do
  @transactions = Transaction.all()
  erb(:"list/all")
end

get '/spending-tracker/list/all/:id/edit' do
  transactions_all = Transaction.all()
  @to_edit = transactions_all.select { |transaction| transaction.id == params[:id] }
  @others = transactions_all.select { |transaction| transaction.id != params[:id] }  }

  @category_groups = CategoryGroup.all()
  @categories = Category.all()
  @time_periods = TimePeriod.all()
  erb(:"list/edit")
end

post '/spending-tracker/list/all/:id' do
  transaction = Transaction.new( params )
  transaction.update()
  redirect to ("/spending-tracker/list/all")
end

post '/spending-tracker/list/all/:id/delete' do
  Transaction.delete( params[:id] )
  redirect to ("/spending-tracker/list/all")
end
