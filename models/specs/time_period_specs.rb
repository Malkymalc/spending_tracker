
require('minitest/autorun')
require('minitest/rg')
require_relative('../time_period')

class TestTimePeriod < Minitest::Test

  def setup
    @date = Date.today()
  end

  def test_date_dot_today_works
    result = @date.to_s
    assert_equal('2018-11-12', result)
  end

  def test_week_start_end
    results_arr = TimePeriod.week_start_end(@date)

    assert_equal('2018-11-12', results_arr[0])
    assert_equal('2018-11-18', results_arr[1])
  end

  def test_month_start_end
    results_arr = TimePeriod.month_start_end(@date)

    assert_equal('2018-11-01', results_arr[0].to_s)
    assert_equal('2018-11-30', results_arr[1].to_s)
  end

  def test_date_range__week
    results_arr = TimePeriod.date_range(@date, 'week')

    assert_equal('2018-11-12', results_arr[0].to_s)
    assert_equal('2018-11-18', results_arr[1].to_s)
  end

  def test_date_range__month
    results_arr = TimePeriod.date_range(@date, 'month')

    assert_equal('2018-11-01', results_arr[0].to_s)
    assert_equal('2018-11-30', results_arr[1].to_s)
  end

end
