require './FoodDB'
require './Log'

class DietManager
  def initialize()
    @dbFile = "FoodDB.txt"
    @logFile = "DietLog.txt"
    @database = FoodDB.new(@dbFile)
    @log = Log.new(@logFile)
    @dbChanged = false
    @logChanged = false

  end
  
  #Handles the 'quit' command which exits the DietManager
  def command_quit
    if (@dbChanged == false)
      abort('The program ended')
    else
      puts ('There are changes to be saved')
    end
  end
  
  #Handles the 'save' command which saves the FoodDB and Log if necessary
  def command_save
    if @dbChanged == true
      @database.save
      @dbChanged = false
    end
    if @logChanged == true
      @log.save
      @logChanged = false
    end
  end

  #Handles the 'new food' command which adds a new BasicFood to the FoodDB
  def command_newFood(name, calories)
    result = @database.add_basicFood(name, calories)
    if (result == true)
      @dbChanged = true
      puts("success")
    else
      puts("fail")
    end
  end

  #Handles the 'new recipe' command which adds a new Recipe to the FoodDB
  def command_newRecipe(name, ingredients)
    result = @database.add_recipe(name, ingredients)
    if (result == true)
      @dbChanged = true
      puts("success")
    else
      puts("fail")
    end
  end

  #Handles the 'print' command which prints a single item from the FoodDB
  def command_print(name)
    result = @database.get(name)
    puts(result)
  end

  #Handles the 'print all' command which prints all items in the FoodDB
  def command_printAll
    puts("\n")
    @database.basicFoods.each do |value|
      puts(value.to_s)
    end
    @database.recipes.each do |value|
      puts(value.to_s)
    end
  end

  #Handles the 'find' command which prints information on all items in the FoodDB matching a certain prefix
  def command_find(prefix)
    result = @database.find_matches(prefix)
    puts(result)
  end

  #Handles both forms of the 'log' command which adds a unit of the named item to the log for a certain date
  def command_log(name, date = Date.today)
    result = @log.add_logItem(name, date)
    if result == true
      @logChanged = true
      puts("success")
    else
      puts("fail")
    end
  end

  #Handles the 'delete' command which removes one unit of the named item from the log for a certain date
  def command_delete(name, date)
    result = @log.remove_logItem(name, date)
    if result == nil
      puts('nothing to remove')
    else
      @logChanged = true
    end
  end

  #Handles both forms of the 'show' command which displays the log of items for a certain date
  def command_show(date = Date.today)
    result = @log.get_entries(date)
    puts(result)
  end

  #Handles the 'show all' command which displays the entire log of items
  def command_showAll
    result = @log.get_entries
    puts(result)
  end
  
end #end DietManager class


#MAIN

dietManager = DietManager.new

puts "Input a command > "

#Read commands from the user through the command prompt
$stdin.each{|line|
  command = line.split(' ')
  
  #Handle the input
  case command[0]
  when 'quit'
    dietManager.command_quit
  when 'print'
    if command[1] == 'all' 
      dietManager.command_printAll #print all
    else
      command.delete_at(0)
      name = command.join(' ')
      dietManager.command_print(name) #print name
    end
  when 'find'
    dietManager.command_find(command[1])
  when 'new'
    if command[1] == 'food'
      command.delete_at(0) #Deleting the word 'new' from the array
      command.delete_at(0) #Deleting the word 'food' from the array

      nameAndCalories = command.join(' ') #Array into String
      nameAndCalories = nameAndCalories.split(',') #String into Array

      dietManager.command_newFood(nameAndCalories[0], nameAndCalories[1])
    elsif command[1] == 'recipe'
      command.delete_at(0)
      command.delete_at(0)

      nameAndIngredients = command.join(' ') #Array into String
      nameAndIngredients = nameAndIngredients.split(',') #String into Array

      recipeName = nameAndIngredients[0]
      nameAndIngredients.delete_at(0) # This way, it will last only an array with the ingredients

      dietManager.command_newRecipe(recipeName, nameAndIngredients)
    end
  when 'save'
    dietManager.command_save
  when 'log'
    command.delete_at(0)

    nameAndDate = command.join(' ') #Array into String
    nameAndDate = nameAndDate.split(',') #String into Array

    if (nameAndDate[1] == nil)
      dietManager.command_log(nameAndDate[0], Date.today)
    else
      onlyDate = nameAndDate[1].split('/')
      dietManager.command_log(nameAndDate[0], Date.new(onlyDate[2].to_i,onlyDate[0].to_i,onlyDate[1].to_i))
    end
  when 'show'
    if (command[1] == 'all')
      dietManager.command_showAll
    elsif (command[1] == nil)
      dietManager.command_show(Date.today)
    else
      date = command[1].split('/')
      dietManager.command_show(Date.new(date[2].to_i, date[0].to_i, date[1].to_i))
    end
  when 'delete'
    command.delete_at(0)
    nameAndDate = command.join(' ') #Array into String
    nameAndDate = nameAndDate.split(',') #String into Array
    onlyDate = nameAndDate[1].split('/') #String into Array
    dietManager.command_delete(nameAndDate[0], Date.new(onlyDate[2].to_i, onlyDate[0].to_i, onlyDate[1].to_i))
    
  end
  
} #closes each iterator
MAIN
