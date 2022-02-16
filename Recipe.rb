require './BasicFood'

class Recipe
  attr_accessor :name, :ingredients, :calories

  #recipeName is the name of this recipe and ingredientsList is the list of BasicFood objects in this recipe
  def initialize(recipeName, ingredientsList)
    @name = recipeName
    @ingredients = ingredientsList.sort{|x, y| x.name <=> y.name} #Sorts the list by ingredient name
    @calories = 0
    
    #Calculate the total calories in this Recipe
    #FILL IN
    @ingredients.each_index do |i|
      @calories += @ingredients[i].calories
    end
  end
  
  #Returns a string representation of this Recipe formatted for printing
  def to_s
    result = ""
    #Build the string we are going to print
    #FILL IN
    result += @name + " " +  @calories.to_s + "\n"
    @ingredients.each_index do |i|
      result += "  " + @ingredients[i].name + " " + @ingredients[i].calories.to_s + "\n"
    end
    return result
  end
end
