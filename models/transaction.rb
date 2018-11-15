require_relative('../db/sql_runner')
require 'date'
require("pry-byebug")

class Transaction

  attr_accessor :id, :amount, :date, :details, :category_id, :time_period_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_f
    @date = Date.parse(options['date_'])
    @details = options['details']
    @category_id = options['category_id'].to_i
    @time_period_id = options['time_period_id'].to_i
  end

# FILTERING METHODS
  def self.date_filter(transactions_arr, start_end_arr)
    start_date, end_date = start_end_arr
    return transactions_arr.select { |transaction|
      transaction.date >= start_date && transaction.date <= end_date
     }
  end

  def self.category_group_filter(transactions_arr, category_group_ids_arr)
    return transactions_arr.select { |transaction|
      category_group_ids_arr.include?(transaction.category_group().id.to_s )
     }
  end

  #For testing without database
  # def self.category_group_filter(transactions_arr, category_ids_arr)
  #   return transactions_arr.select { |transaction|
  #     category_ids_arr.include?( transaction.category_id)
  #    }
  # end

#GROUPING METHODS
  def self.group_by_cat(transactions_arr)
    grouping_obj = transactions_arr.reduce({}) { |obj, transaction|
      c_g_name = transaction.category_group().name
      obj.has_key?(c_g_name) ? obj[c_g_name].push(transaction) : obj[c_g_name] = [transaction]
    }
    return grouping_obj
  end

  def self.group_by_day(transactions_arr)
    day = '%A'
    grouping_obj = transactions_arr.reduce({}) { |obj, transaction|
      day_name = transaction.date.strftime(day)
      obj.has_key?(day_name) ? obj[day_name].push(transaction) : obj[day_name] = [transaction]
    }
    return grouping_obj
  end

  def self.group_by_week(transactions_arr)
    week = '%U'
    grouping_obj = transactions_arr.reduce({}) { |obj, transaction|
      week_name = transaction.date.strftime(week)
      obj.has_key?(week_name) ? obj[week_name].push(transaction) : obj[week_name] = [transaction]
    }
    return grouping_obj
  end

  # SUMMARISING METHODS
  def self.sum(transactions_arr)
    return transactions_arr.reduce(0.00) { |total, transaction|
      total += transaction.get_weekly()
    }
  end

  def self.sum_actual(transactions_arr)
    return transactions_arr.reduce(0.00) { |total, transaction|
      total += transaction.amount
    }
  end


# CRUD METHODS
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
    sql = "SELECT * FROM categories WHERE id = $1"
    values = [@category_id]
    category = SqlRunner.run( sql, values )[0]
    return Category.new(category)
  end

  def category_group()
    #binding.pry
    return category().category_group()
  end

  def self.find(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run( sql, values ).first
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
      SET (amount, date_ , details, category_id, time_period_id)
      = ($1, $2, $3, $4, $5)
      WHERE id = $6"
      values = [@amount, @date, @details, @category_id, @time_period_id, @id]
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
