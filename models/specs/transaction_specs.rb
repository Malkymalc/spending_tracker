
require('minitest/autorun')
require('minitest/rg')
require_relative('../transaction.rb')
require_relative('../time_period.rb')
require_relative('../category.rb')
require_relative('../category_group.rb')

class TestTransaction < Minitest::Test

  def setup
    time_period1 = TimePeriod.new({
      "id" => 1,
      "name" => "Daily / Weekly",
      "numerator" => 52,
      "denominator" => 52
      })

    time_period2 = TimePeriod.new({
      "id" => 2,
      "name" => "Fortnightly",
      "numerator" => 26,
      "denominator" => 52
      })

    @transaction1 = Transaction.new({
      "amount" => 10.00,
      "date_" => "2001-11-14",
      "details" => "Lots of coffee",
      "category_id" => 11,
      "time_period_id" => 2
      })

    @transaction2 = Transaction.new({
      "amount" => 9.35,
      "date_" => "2001-11-26",
      "details" => "Lots of coffee",
      "category_id" => 11,
      "time_period_id" => 1
      })

    @transaction3 = Transaction.new({
      "amount" => 10.65,
      "date_" => "2001-08-26",
      "details" => "Lots of coffee",
      "category_id" => 11,
      "time_period_id" => 1
      })

    @transactions = [@transaction1, @transaction2, @transaction3]

    @date = Date.today()
  end


  def test_date_filter
    date_arr = [(Date.today()-2), Date.today()+2]
    result = Transaction.date_filter(@transactions, date_arr)
    assert_equal([@transaction1, @transaction2], result)
  end

  def test_category_group_filter
    group_arr = []
    result = Transaction.category_group_filter(@transactions, group_arr)
    assert_equal([], result)
  end

  #
  # def test_group_by_cat
  #   actual = Transaction.group_by_cat(@transactions)
  #   expected = {
  #     "Income" => [@transaction1]
  #   }
  #   assert_equal(expected, actual)
  # end
  #
  # def test_group_by_day
  #   result = Transaction.group_by_day(@transactions)
  #   expected = {
  #     "Monday" => [@transaction2]
  #   }
  #   assert_equal(expected, actual)
  # end
  #
  # def test_group_by_week
  #   result = Transaction.group_by_week(@transactions)
  #   expected = {
  #     "3" => [@transaction3]
  #   }
  #   assert_equal(expected, actual)
  # end


  def test_sum
    result = Transaction.sum(@transactions)
    p result
    assert_in_delta(25.00, result)
  end

  def test_sum_actual
    result = Transaction.sum_actual(@transactions)
    assert_in_delta(30.00, result)
  end



end
