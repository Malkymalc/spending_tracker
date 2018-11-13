require_relative('../db/sql_runner')
require 'date'

class Budget

  attr_accessor :id, :amount, :date, :details, :category_id, :time_period_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_f
    @date = Date.parse(options['date_'])
    @details = options['details']
    @category_id = options['category_id'].to_i
    @time_period_id = options['time_period_id'].to_i
  end

# CREATE
  def save()
    sql = "
    INSERT INTO transactions
    (amount, date_, details, category_id, time_period_id)
    VALUES ( $1, $2, $3, $4, $5 )
    RETURNING id"
    values = [@amount, @date, @details, @category_id, @time_period_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

# READ

  def time_period()
    sql = "SELECT * FROM time_periods WHERE id = $1"
    values = [@time_period_id]
    time_period = SqlRunner.run(sql, values)[0]
    return TimePeriod.new(time_period)
  end

  def get_weekly()
    return @amount * time_period().get_divisor()
  end

  def category()
    sql = "SELECT * FROM categories WHERE category_id = $1"
    values = [@category_id]
    category = SqlRunner.run( sql, values )
    return Category.new(category)
  end

  def category_group()
    return category().category_group()
  end

  def self.find(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run( sql )
    return Transaction.new( transaction )
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    transactions = SqlRunner.run( sql )
    return transactions.map { |transaction| Transaction.new( transaction ) }
  end

# UPDATE

def update()
    sql = "UPDATE transactions
    SET (amount, date_, details, category_id, time_period_id)
    = ($1, $2, $3, $4, $5)
    WHERE id = $6"
    values = [@amount, @date, @details, @category_id, @time_period, @id]
    SqlRunner.run(sql, values)
  end

# DELETE
  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.delete(id)
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end



end
