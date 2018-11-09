require_relative('../db/sql_runner')

class TimePeriod

  attr_accessor :id, :name, :divisors

  @@names = ['daily/weekly', 'fortnightly', '4 weekly', 'monthly', 'quarterly', 'yearly']

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @divisors = {
      'daily/weekly' => (1/1),
      'fortnightly' => (1/2),
      '4 weekly' => (1/4),
      'monthly' => (12/52),
      'quarterly' => (4/52),
      'yearly' => (1/52)
    }
  end

  def self.names()
    return @@names
  end

  def get_divisor()
    return @divisors[@name]
  end

  CRUD


end
