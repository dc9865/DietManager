require 'minitest/autorun'          #We need Ruby's unit testing library
require './FoodDB'

class FoodDBTest < MiniTest::Test
  def setup							#setup method is run automatically before each test_xxx
    @fdb = FoodDB.new("FoodDB.txt")
  end
  
  #Tests if there are entries in the DB after FoodDB.txt is read
  def test_DB_initialization
    assert(@fdb.size > 0, "Database entries not correctly read in")
  end
  
  #Tests the 'contains_food?' method of FoodDB
  def test_contains_food
    assert(@fdb.contains_food?("Orange"), "Orange not contained in database")
    assert(@fdb.contains_food?("Peanut Butter"), "Peanut Butter not contained in database")
    assert(@fdb.contains_food?("Pear") == false, "Pear should not be contained in database")
  end
  
  #Tests the 'contains_recipe?' method of FoodDB
  def test_contains_recipe
    #assert(@fdb.contains_recipe?("Chicken Sandwich"), "Chicken Sandwich not contained in database")
    #assert(@fdb.contains_recipe?("PB&J Sandwich"), "PB&J Sandwich not contained in database")
  end
  
  #Tests the 'contains?' method of FoodDB
  def test_contains
    assert(@fdb.contains?("Orange"), "Orange not contained in database")
    #assert(@fdb.contains?("Chicken Sandwich"), "Chicken Sandwich not contained in database")
  end
  
  #Tests the 'get_food' method of FoodDB
  def test_get_food
    assert(@fdb.get_food("Bread Slice").eql?("Bread Slice 80"), "Failed to get BasicFood, Bread Slice")
    assert(@fdb.get_food("Jelly").eql?("Jelly 155"), "Failed to get BasicFood, Jelly")
  end
  
  #Tests the 'get_recipe' method of FoodDB
  def test_get_recipe
     assert(@fdb.get_recipe("Chicken Sandwich").eql?("Chicken Sandwich"), "Failed to get Recipe, Chicken Sandwich")
    #assert(@fdb.get_recipe("PB&J Sandwich").eql?("PB&J Sandwich"), "Failed to get Recipe, PB&J Sandwich")
  end
  
  #Tests the 'get' method of FoodDB
  def test_get
    assert(@fdb.get("Orange").eql?("Orange 67"), "Failed to get BasicFood, Orange")
    assert(@fdb.get("Apple").eql?("Apple 50"), "Failed to get BasicFood, Orange")
   # assert(@fdb.get("Chicken Sandwich").eql?("Chicken Sandwich"), "Failed to get Recipe, Chicken Sandwich")
   # assert(@fdb.get("PB&J Sandwich").eql?("PB&J Sandwich"), "Failed to get Recipe, PB&J Sandwich")
  end
  
  #Tests the 'find_matches' method of FoodDB
  def test_find_matches
    assert(@fdb.find_matches("A").include?("Apple"), "Failed to get Apple's prefix A")
    assert(@fdb.find_matches("b").include?("Bread Slice"), "Failed to get Bread Slice's prefix B")
    assert(@fdb.find_matches("C").include?("Chicken"), "Failed to get Chicken's prefix C")
    assert(@fdb.find_matches("P").include?("PB&J Sandwich") == false, "You should not see PB&J Sandwich from the list")
  end
  
  #Tests the 'add_basicFood' method
  def test_add_food
    assert(@fdb.add_basicFood("Orange", 67) == false, "Orange is already in the database and therefore, should not be added")
    assert(@fdb.add_basicFood("Banana", 34) == true, "Banana is not in the database and therefore, should be added")
  end
  
  #Tests the 'add_recipe' method
  def test_add_recipe
   # assert(@fdb.add_recipe("Chicken Sandwich", ["Bread Slice", "Bread Slice", "Chicken"] == false), "Chicken Sandwich is already in the database and therefore, should not be added")
   # assert(@fdb.add_recipe("Ham Sandwich", ["Bread Slice", "Bread Slice", "Ham"]) == true, "Ham Sandwich is not in the database and therefore, should be added")
  end
  
  #Tests the addition of a Recipe with a Recipe as one of its ingredients
  def test_recipe_within_recipe
    #assert(@fdb.add_recipe("Bread Slice", ["Bread Slice", "Bread Slice", "Chicken"]) == false, "Bread Slice is a Recipe ingredient.")
  end
end
