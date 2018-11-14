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
get '/spending-tracker/time-periods' do
  @time_periods = TimePeriod.all()

  erb (:'time-periods/index')
end

# new (Create)
get '/spending-tracker/time-periods/new' do
  @time_periods = TimePeriod.all()
  erb (:'time-periods/new')
end

post '/spending-tracker/time-periods' do
  time_period = TimePeriod.new( params )
  time_period.save()
  redirect to '/spending-tracker/time-periods'
end

# edit (Update)
get '/spending-tracker/time-periods/:id/edit' do
  @time_period = TimePeriod.find( params[:id] )
  @time_periods = TimePeriod.all()
  .select { |time_period|
    time_period.id != @time_period.id
  }
  erb (:'time-periods/edit')
end

post '/spending-tracker/time-periods/:id' do
  time_period = TimePeriod.new( params )
  time_period.update()
  redirect to '/spending-tracker/time-periods'
end

# delete (Delete)
post '/spending-tracker/time-periods/:id/delete' do
  time_period = TimePeriod.find( params[:id] )
  time_period.delete()
  redirect to 'spending-tracker/time-periods'
end
