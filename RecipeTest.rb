require 'minitest/autorun'          #We need Ruby's unit testing library
require_relative 'Recipe'

class RecipeTest < MiniTest::Test
  def setup
    @bread = BasicFood.new("Bread", 80)
    @pb = BasicFood.new("Peanut Butter", 175)
    @jelly = BasicFood.new("Jelly", 155)
    @recipe = Recipe.new("PB&J", [@bread, @pb, @jelly, @bread])
  end

  #Tests the initial construction of a Recipe
  def test_construction
    assert_equal "PB&J", @recipe.name, "Recipe name should be PB&J"
    assert_equal "Bread", @recipe.ingredients[0].name, "First ingredient from the recipe should be Bread"
    assert_equal 80, @recipe.ingredients[0].calories, "Bread's calories shouold be 80"
    assert_equal "Bread", @recipe.ingredients[1].name, "Second ingredient from the recipe shouldbe Bread"
    assert_equal "Jelly", @recipe.ingredients[2].name, "Third ingredient from the recipe should be Jelly"
    assert_equal "Peanut Butter", @recipe.ingredients[3].name, "Last ingredient from the recipe should be Peanut Butter"

  end
  
  #Tests the 'to_s' method of Recipe
  def test_to_s
    first_line = "PB&J 490\n"
    second_line = "  Bread 80\n"
    third_line = "  Bread 80\n"
    fourth_line = "  Jelly 155\n"
    fifth_line = "  Peanut Butter 175\n"
    assert(@recipe.to_s.eql?(first_line + second_line + third_line + fourth_line + fifth_line), "to_s method formats string improperly")

  end
  
end
