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

  def save()
    sql = "INSERT INTO bitings
    (
      zombie_id,
      victim_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@zombie_id, @victim_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM bitings"
    results = SqlRunner.run( sql )
    return results.map { |biting| Biting.new( biting ) }
  end

  def victim()
    sql = "SELECT * FROM victims
    WHERE id = $1"
    values = [@victim_id]
    results = SqlRunner.run( sql, values )
    return Victim.new( results.first )
  end

  def zombie()
    sql = "SELECT * FROM zombies
    WHERE id = $1"
    values = [@zombie_id]
    results = SqlRunner.run( sql, values )
    return Zombie.new( results.first )
  end

  def self.delete_all()
    sql = "DELETE FROM bitings"
    SqlRunner.run( sql )
  end

  def self.destroy(id)
    sql = "DELETE FROM bitings
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end


end
