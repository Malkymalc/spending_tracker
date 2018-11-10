require_relative('../db/sql_runner')

class TimePeriod

  attr_accessor :id, :name, :numerator, :denominator

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @numerator = options[''].to_i
    @denominator = options[''].to_i
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
    time_period = SqlRunner.run( sql )
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
