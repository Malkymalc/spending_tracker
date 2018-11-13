require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('../models/budget.rb')
require_relative('../models/category.rb')
require_relative('../models/category_group.rb')
require_relative('../models/time_period.rb')
require_relative('../models/transaction.rb')
also_reload( '../models/*' )

# index (Read)
get '/spending-tracker/categories' do
  @categories = Category.all()
  @category_groups = CategoryGroup.all()
  erb (:'categories/index')
end

# new (Create)
get '/spending-tracker/categories/new' do
  @categories = Category.all()
  erb (:'categories/new')
end

post '/spending-tracker/categories' do
  category = Category.new( params )
  category.save()
  redirect to '/spending-tracker/categories'
end

# edit (Update)
get '/spending-tracker/categories/:id/edit' do
  @category = Category.find( params[:id] )
  @categories = Category.all()
  .select { |category|
    category.id != @category.id
  }
  erb (:'categories/edit')
end

post '/spending-tracker/categories/:id' do
  category = Category.new( params )
  category.update()
  redirect to '/spending-tracker/categories'
end

# delete (Delete)
post '/spending-tracker/categories/:id/delete' do
  category = Category.find( params[:id] )
  category.delete()
  redirect to 'spending-tracker/categories'
end
