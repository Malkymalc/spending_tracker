
require('minitest/autorun')
require('minitest/rg')
require_relative('../time_period')

class TestTimePeriod < Minitest::Test

  def setup
    @date = Date.today()
  end

  def test_date_dot_today_works
    result = @date.cwday()
    assert_equal(3, result)
  end

  # def test_week_start_end
  # end
  #
  # def test_month_start_end
  # end
  #
  # def test_date_range
  #
  # end

end
