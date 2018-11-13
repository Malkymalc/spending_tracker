require_relative('../db/sql_runner')
require 'date'

class TimePeriod

  attr_accessor :id, :name, :numerator, :denominator

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @numerator = options['numerator'].to_i
    @denominator = options['denominator'].to_i
  end


  def self.week_start_end(date)
    back, forward = 0, 0
    while (date - back).cwday() != 1
      back += 1
    end
    while (date + forward).cwday() != 7
      forward += 1
    end
    return [(date - back), (date + forward)]
  end

  def self.month_start_end(date)
    back, forward = 0, 0
    #increase back unitl mday is 1 then return date - back
    while (date - back).mday() != 1
      back += 1
    end
    #increase forward until mday is 1 then return date + (forward - 1)
    while (date + forward).mday() != 1
      forward += 1
    end
    return [( date - back ), ( date + (forward-1) )]
  end

  # def self.quarter_start_end(date)
  #   #increase back unitl mday is 1 then return date - back
  #   #increase forward until mday is 1 then return date + (forward - 1)
  #   return [(date - back), (date + (forward)-1)]
  # end

  def self.date_range(date, range_type)
    return week_start_end(date) if range_type == 'week'
    return month_start_end(date) if range_type == 'month'
    # return quarter_start_end(date) if range_type == 'quarter'
  end

  def get_divisor()
    return @numerator.to_f / @denominator
  end

# CREATE
  def save()
    sql = "
    INSERT INTO time_periods
    (name, numerator, denominator)
    VALUES ( $1, $2, $3 )
    RETURNING id"
    values = [@name, @numerator, @denominator]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

# READ
  def transactions()
    sql = "SELECT * FROM transactions
    WHERE time_period_id = $1"
    values = [@id]
    transactions = SqlRunner.run( sql, values )
    return transactions.map { |transaction| Transaction.new(transaction) }
  end

  def self.find(id)
    sql = "SELECT * FROM time_periods
    WHERE id = $1"
    values = [id]
    time_period = SqlRunner.run( sql, values ).first
    return TimePeriod.new( time_period )
  end

  def self.all()
    sql = "SELECT * FROM time_periods"
    time_periods = SqlRunner.run( sql )
    return time_periods.map { |time_period| TimePeriod.new( time_period ) }
  end

# UPDATE

def update()
    sql = "UPDATE time_periods
    SET (name, numerator, denominator) = ($1, $2, $3)
    WHERE id = $4"
    values = [@name, @numerator, @denominator, @id]
    SqlRunner.run(sql, values)
  end

# DELETE
  def delete()
    sql = "DELETE FROM time_periods
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.delete(id)
    sql = "DELETE FROM time_periods
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM time_periods"
    SqlRunner.run( sql )
  end


end
