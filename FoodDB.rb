require './BasicFood.rb'
require './Recipe.rb'

class FoodDB
  attr_reader :size, :basicFoods, :recipes
  
  #filename is the name of the FoodDB file to be used, ex: "FoodDB.txt"
  def initialize(filename)
    @size = 0
  
    @dbFile = File.new(filename) #Open the database file
    
    @basicFoods = []
    @recipes = []
    
    #Read in the FoodDB file
    @dbFile.each{|line|
      values = line.split(',') #Split the line up at the commas
      
      if values[1] == 'b' #BasicFood case
        add_basicFood(values[0], values[2].to_i) #Add the new food to our list
      elsif values[1] == 'r' #Recipe case
        values[2..values.length].each{|ingredient| ingredient.chomp!} #Remove newline characters
        add_recipe(values[0], values[2..values.length]) #Add the new Recipe to the recipes list
      else #The entry is invalid
        values[0].chomp.eql?("") ? nil : puts("Invalid food type found in FoodDB.txt")
      end
    }
  end
  
  #Returns true if a BasicFood with the name foodName exists in the database
  def contains_food?(foodName)
    contains = false
    #FILL IN
    @basicFoods.each do |value|
      if value.name == foodName
        contains = true
      end
    end
    return contains
  end
  
  #Returns true if a Recipe with the name recipeName exists in the database
  def contains_recipe?(recipeName)
    contains = false
    #FILL IN
    @recipes.each do |value|
      if value.name == recipeName
        contains = true
      end
    end
    return contains
  end
  
  #Returns true if there exists some entry in the database with the name itemName
  def contains?(itemName)
    #FILL IN
    contains = false
    if contains_food?(itemName)
      contains = true
    elsif contains_recipe?(itemName)
      contains = true
    end
    return contains
  end
  
  #Returns the BasicFood of the given name if it exists within the database, nil otherwise
  def get_food(foodName)
    #FILL IN
    @basicFoods.each do |basicfood|
      if basicfood.name == foodName
        return basicfood.to_s
      end
    end
    return nil
  end
  
  #Returns the Recipe of the given name if it exists within the database, nil otherwise
  def get_recipe(recipeName)
    #FILL IN
    @recipes.each do |recipe|
      if recipe.name == recipeName
        return recipe
      end
    end
    return nil
  end
  
  #Returns the item of the given name if it exists within the database, nil otherwise
  def get(itemName)
    #If the item is a BasicFood and is in the database, return it
    #Else, if the item is a Recipe and is in the database, return it
    #Return nil otherwise
    #FILL IN
    result = get_food(itemName)
    if result == nil
      result = get_recipe(itemName)
      if result == nil
        return nil
      end
    end
    return result
      
  end
  
  #Returns a list of all items in the database that begin with the given prefix
  def find_matches(prefix)
    #FILL IN
    @basicFoods.each do |value|
      if value.name.downcase.start_with? prefix.downcase
        return value.to_s
      end
    end

    @recipes.each do |value|
      if value.name.downcase.start_with? prefix.downcase
        return value.to_s
      end
    end
  end
  
  #Constructs a new BasicFood and adds it to the database, returns true if successful, false otherwise
  def add_basicFood(name, calories)
    #Don't add if it is already in the database
    #FILL IN
    #checks if it is BasicFood or Recipe
    if contains?(name)
      return false
    else
      @basicFoods << BasicFood.new(name,calories)
      return true
    end
    return false
  end
  
  #Constructs a new Recipe and adds it to the database, returns true if successful, false otherwise
  def add_recipe(name, ingredientNames)
    #Don't add if it is already in the database
    #FILL IN
    #checks if it is BasicFood or Recipe
    if contains?(name)
      return false
    else
      ingredients = Array.new(0)
      ingredientNames.each do |value|
        ingredients << get_food(value)
      end
      @recipes << Recipe.new(name, ingredients)
      return true
    end
    return false
  end
  
  #Saves the database to @dbFile
  def save
    File.open(@dbFile, "w+"){|fOut|
      #Write all BasicFoods to the database
      @basicFoods.each{|food| fOut.write("#{food.name},b,#{food.calories}\n")}
      fOut.write("\n")
      
      #Write all Recipes to the database
      @recipes.each{|recipe|
        fOut.write("#{recipe.name},r")
        
        #List the ingredients after the recipe name
        recipe.ingredients.each{|ingredient| fOut.write(",#{ingredient.name}")}
        fOut.write("\n")
      }
    }
  end
end
