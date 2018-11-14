
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

    category_group1 = CategoryGroup.new({
      "id" => 1,
      "name" => "Quality of Life",
      "colour" => "#adf352",
      })

    category_group2 = CategoryGroup.new({
      "id" => 2,
      "name" => "Health",
      "colour" => "#d58291",
      })

    category1 = Category.new({
      "id" => 1,
      "name" => "Coffeeeee Etc.",
      "category_group_id" => 1,
      })

    category2 = Category.new({
      "id" => 2,
      "name" => "Cakes",
      "category_group_id" => 1,
      })

    category3 = Category.new({
      "id" => 3,
      "name" => "Gym",
      "category_group_id" => 2,
      })


    @transaction1 = Transaction.new({
      "amount" => 10.00,
      "date_" => "2018-11-15",
      "details" => "Venti Filter",
      "category_id" => 1,
      "time_period_id" => 2
      })

    @transaction2 = Transaction.new({
      "amount" => 9.35,
      "date_" => "2018-11-12",
      "details" => "Cheesecake",
      "category_id" => 2,
      "time_period_id" => 1
      })

    @transaction3 = Transaction.new({
      "amount" => 10.65,
      "date_" => "2018-08-26",
      "details" => "CSE - Pleasance Gym",
      "category_id" => 3,
      "time_period_id" => 1
      })

    @transactions = [@transaction1, @transaction2, @transaction3]

    @date = Date.today()
  end


  def test_date_filter
    date_arr = [(Date.today()-2), (Date.today()+2)]
    result = Transaction.date_filter(@transactions, date_arr)
    assert_equal([@transaction1, @transaction2], result)
  end

  def test_category_group_filter
    group_arr = [1,2]
    result = Transaction.category_group_filter(@transactions, group_arr)
    assert_equal([@transaction1, @transaction2], result)
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
