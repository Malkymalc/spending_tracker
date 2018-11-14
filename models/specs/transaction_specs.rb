
require('minitest/autorun')
require('minitest/rg')
require_relative('../transaction')

class TestTransaction < Minitest::Test

  def setup


    @transactions = []
  end

  def test_date_filter
    result = Transaction.date_filter(@transactions)
    assert_equal([], result)
  end

  def test_category_group_filter
    result = Transaction.category_group_filter(@transactions)
    assert_equal([], result)
  end


  def test_group_by_cat
    actual = Transaction.group_by_cat(@transactions)
    expected = {
      "Income" => [@transaction1]
    }
    assert_equal(expected, actual)
  end

  def test_group_by_day
    result = Transaction.group_by_day(@transactions)
    expected = {
      "Monday" => [@transaction2]
    }
    assert_equal(expected, actual)
  end

  def test_group_by_week
    result = Transaction.group_by_week(@transactions)
    expected = {
      "3" => [@transaction3]
    }
    assert_equal(expected, actual)
  end


  def test_sum
    result = Transaction.sum(@transactions)
    assert_equal(50.89, result)
  end

  def test_sum_actual
    result = Transaction.sum(@transactions)
    assert_equal(34.42, result)
  end



end
