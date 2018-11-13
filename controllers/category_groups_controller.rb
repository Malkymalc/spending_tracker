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
get '/spending-tracker/category-groups' do
  @category_groups = CategoryGroup.all()
  erb (:'category-groups/index')
end

# new (Create)
get '/spending-tracker/category-groups/new' do
  @category_groups = CategoryGroup.all()
  erb (:'category-groups/new')
end

post '/spending-tracker/category-groups' do
  category_group = CategoryGroup.new( params )
  category_group.save()
  redirect to '/spending-tracker/category-groups'
end

# edit (Update)
get '/spending-tracker/category-groups/:id/edit' do
  @category_group = CategoryGroup.find( params[:id] )
  @category_groups = CategoryGroup.all()
  .select { |category_group|
    category_group.id != @category_group.id
  }
  erb (:'category-groups/edit')
end

post '/spending-tracker/category-groups/:id' do
  category_group = CategoryGroup.new( params )
  category_group.update()
  redirect to '/spending-tracker/category-groups'
end

# delete (Delete)
post '/spending-tracker/category-groups/:id/delete' do
  category_group = CategoryGroup.find( params[:id] )
  category_group.delete()
  redirect to 'spending-tracker/category-groups'
end
