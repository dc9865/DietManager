require 'minitest/autorun'          #We need Ruby's unit testing library
require_relative './LogItem'

class LogItemTest < MiniTest::Test
  def setup
    @item = LogItem.new("Orange", Date.today)
  end
  
  #Tests the basic construction of a LogItem object
  def test_construction
    assert_equal("Orange", @item.name, "Item name should be Orange")
    assert_equal(Date.today, @item.date, "Date should be " + Date.today.to_s)
  end
  
  #Tests the 'to_s' method of LogItem
  def test_to_s
    assert_equal(Date.today.to_s + " Orange", @item.to_s, "Item date and name should be " + Date.today.to_s + " Orange")
  end
  
end
