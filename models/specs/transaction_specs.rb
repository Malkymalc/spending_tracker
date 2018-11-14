
require('minitest/autorun')
require('minitest/rg')
require_relative('../transaction')

class TestTransaction < Minitest::Test

  def setup
    @customers =


  end

  def test_increase_pets_sold
    increase_pets_sold(@pet_shop,2)
    sold = pets_sold(@pet_shop)
    assert_equal(2, sold)
  end

end
