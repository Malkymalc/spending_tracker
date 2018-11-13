require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('../models/budget.rb')
require_relative('../models/category.rb')
require_relative('../models/category_group.rb')
require_relative('../models/time_period.rb')
require_relative('../models/transaction.rb')
also_reload( '../models/*' )

#CREATE
get '/spending-tracker/category/new' do
  @category_groups = CategoryGroup.all()
  erb(:"categories/add")
end

get '/spending-tracker/category_group/new' do
  @category_groups = CategoryGroup.all()
  erb(:"category_group/add")
end

post '/spending-tracker/category' do
  category = Category.new( params )
  category.save()
  #confirmation page?
  redirect to  ("categories/all")
end

post '/spending-tracker/category_group' do
  category_group = CategoryGroup.new( params )
  category_group.save()
  #confirmation page?
  redirect to  ("categories/all")
end

# DELETE
post '/spending-tracker/categories/all/:id/delete' do
  Category.delete( params[:id] )
  redirect to ("/spending-tracker/categories/all")
end

post '/spending-tracker/category_groups/all/:id/delete' do
  CategoryGroup.delete( params[:id] )
  redirect to ("/spending-tracker/categories/all")
end


#UPDATE
get '/spending-tracker/categories/all/:id/edit' do
  transactions_all = Transaction.all()
  @to_edit = transactions_all.select { |transaction| transaction.id == params[:id] }
  @others = transactions_all.select { |transaction| transaction.id != params[:id] }

  @category_groups = CategoryGroup.all()
  @categories = Category.all()
  @time_periods = TimePeriod.all()
  erb(:"spending-tracker/categories/edit")
end

get '/spending-tracker/categories/all/:id/edit' do
  transactions_all = Transaction.all()
  @to_edit = transactions_all.select { |transaction| transaction.id == params[:id] }
  @others = transactions_all.select { |transaction| transaction.id != params[:id] } 

  @category_groups = CategoryGroup.all()
  @categories = Category.all()
  @time_periods = TimePeriod.all()
  erb(:"spending-tracker/category-groups/edit")
end

post '/spending-tracker/categories/all/:id' do
  transaction = Transaction.new( params )
  transaction.update()
  redirect to ("/spending-tracker/categories/all")
end

post '/spending-tracker/category_groups/all/:id' do
  category_group = CategoryGroup.new( params )
  category_group.update()
  redirect to ("/spending-tracker/categories/all")
end



#READ
get '/spending-tracker/categories/all' do
  @category_groups = CategoryGroup.all()
  erb(:"categories/all")
end
