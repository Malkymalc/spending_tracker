require_relative('../db/sql_runner')
require 'date'

class Transaction

  attr_accessor :id, :amount, :details, :category_id, :time_period_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_f
    @date = Date.parse(options['date'])
    @details = options['details']
    @category_id = options['category_group_id'].to_i
    @time_period_id = options['time_period_id'].to_i
  end

  def get_weekly()
    sql = "SELECT * FROM time_periods WHERE id = $1"
    values = [@time_period_id]
    time_period = SqlRunner.run(sql, values)[0]
    return @amount / time_period.get_divisor()
  end

end
