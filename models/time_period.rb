require_relative('../db/sql_runner')

class TimePeriod

  attr_accessor :id, :amount, :date, :details, :category_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @@name = ['daily/weekly', 'fortnightly', '4 weekly', 'monthly', 'quarterly', 'yearly']
    @name = options['name']
    @divisors = {
      'daily/weekly' => '',
      'fortnightly' => '',
      '4 weekly' => '',
      '' => '',
      '' => ''
    }
  end

  def get_divisor()
    return @divisors[@name]
  end


end
