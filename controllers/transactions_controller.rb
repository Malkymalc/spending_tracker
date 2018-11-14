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
  @today = Date.today()
  groups = CategoryGroup.all().map { |cat| cat.id }
  group_by = nil

  @transactions = Transaction.all()
  @category_groups = CategoryGroup.all()
  @time_periods = TimePeriod.all()

  erb (:'transactions/index')
end

post '/spending-tracker/transactions/filtered' do
  transactions_all = Transaction.all()
  @category_groups = CategoryGroup.all()
  @time_periods = TimePeriod.all()

  #Filtering
  date = Date.parse(params[:date])
  date_range = params[:date_range]
  start_end = TimePeriod.date_range(date, date_range)
  groups = params[:groups]

  transactions_date = Transaction.date_filter(transactions_all, start_end)
  @transactions = Transaction.category_group_filter(transactions_date, groups)

  # Grouping
  group_by = params[:group_by]

  @t_grouped = nil if group_by == '0'
  @t_grouped = Transaction.group_by_day(@transactions) if group_by == 'day'
  @t_grouped = Transaction.group_by_week(@transactions) if group_by == 'week'
  @t_grouped = Transaction.group_by_cat_group(@transactions) if group_by == 'category'
  binding.pry
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
