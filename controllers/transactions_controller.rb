require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require 'date'
require_relative('../models/budget.rb')
require_relative('../models/category.rb')
require_relative('../models/category_group.rb')
require_relative('../models/time_period.rb')
require_relative('../models/transaction.rb')
also_reload( '../models/*' )

# index (Read)
get '/spending-tracker/transactions' do
  date = Date.today()
  groups = CategoryGroup.all().map { |cat| cat.id }
  group_by = nil

  @transactions = Transaction.all()
  @category_groups = CategoryGroup.all()
  @time_periods = TimePeriod.all()

  erb (:'transactions/index')
end

post '/spending-tracker/transactions/filtered' do
  date = params[:date]
  groups = params[:groups]
  group_by = params[:group_by]

  transactions_all = Transaction.all()
  transactions_date = Transaction.date_filter(transactions_all, date)
  @transactions = Transaction.category_group_filter(transactions_date, groups)

  @t_grouped = nil if group_by == '0' # no grouping
  @t_grouped = Transaction.group_by_day(@transactions) if group_by == 'day' # day
  @t_grouped = Transaction.group_by_week(@transactions) if group_by == 'week' # week
  @t_grouped = Transaction.group_by_cat_group(@transactions) if group_by == 'category' # category

  @category_groups = CategoryGroup.all()
  @time_periods = TimePeriod.all()

  erb (:'transactions/index')
end


# new (Create)
get '/spending-tracker/transactions/new' do
  @transactions = Transaction.all()
  @category_groups = CategoryGroup.all()
  @categories = Category.all()
  @time_periods = TimePeriod.all()
  erb (:'transactions/new')
end

post '/spending-tracker/transactions' do
  transaction = Transaction.new( params )
  transaction.save()
  redirect to '/spending-tracker/transactions'
end

# edit (Update)
get '/spending-tracker/transactions/:id/edit' do
  @transaction = Transaction.find( params[:id] )
  @transactions = Transaction.all()
  .select { |transaction|
    transaction.id != @transaction.id
  }

  @category_groups = CategoryGroup.all()
  @categories = Category.all()
  @time_periods = TimePeriod.all()

  erb (:'transactions/edit')
end

post '/spending-tracker/transactions/:id' do
  transaction = Transaction.new( params )
  transaction.update()
  redirect to '/spending-tracker/transactions'
end

# delete (Delete)
post '/spending-tracker/transactions/:id/delete' do
  transaction = Transaction.find( params[:id] )
  transaction.delete()
  redirect to 'spending-tracker/transactions'
end
