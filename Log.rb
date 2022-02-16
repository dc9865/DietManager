require './LogItem'

class Log
  attr_accessor :size
  
  #filename is the name of the Log file to be used
  def initialize(filename)
    @log = Hash.new
    @size = 0
    
    
	@logFile = File.new(filename) #Open the log file
    
    #Read in the Log file
    @logFile.each{|line|
      values = line.split(',') #Split the line at the commas
      dateParts = values[0].split('/') #Split the date field up at the slashes
      
      date = Date.parse("#{dateParts[2]}-#{dateParts[0]}-#{dateParts[1]}") #Parse the date string into a valid Date object
      
      add_logItem(values[1].chomp!, date)
    }
  end
  
  #Adds a LogItem to the Log for the given date and name, returns true if successful, false otherwise
  def add_logItem(name, date)  
    #If there are already entries for logItem's date, add the LogItem
    #Otherwise add a new entry for logItem's date and add the LogItem to its list
    #FILL IN
    logItem = Hash.new(LogItem.new(name,date))
    #if (contains?(name, date))
      #@log[date].push(logItem)
      #@size += 1
      #return true
    #else
    @log[date] = []
    @log[date].push(logItem)
    @size += 1
    return true
    #end
    #return false
  end
  
  #Removes a LogItem from the Log for the given date and name
  def remove_logItem(name, date)
    #FILL IN
    @log.each do |value|
      if (value.name == name && value.date == date)
        @log.delete(value)
        @size -= 1
        return
      end
    end
    return nil
  end
  
  #Returns true if there is an entry for this date with the given name, false otherwise
  def contains?(name, date)
    #FILL IN
    logItem = Hash.new(LogItem.new(name,date))
    if @log.merge(logItem) == @log
      return true
    end
    return false
  end
  
  #Returns an Array of LogItems for the given date, nil if there are no entries for the date
  #If no date is passed, returns all entries in the Log
  def get_entries(date = nil)
    #FILL IN
    #@log.sort!{|a,b| a.date <=> b.date
    hashOfNames = Hash.new(0)
    names = Array.new(0)
    
    if date == nil
      @log.each do |key|
        names << @log[key]
      end
      return names
    else
      @log.each do |key|
        if @log[key] == date
          names << @log[key]
        end
      end
      return names
    end
    return nil
  end
  
  #Saves the log to @logFile
  def save
    #Write all save data to the log file
    File.open(@logFile, "w+"){|fOut|
      get_entries.flatten.each{|logItem|
        fOut.write(logItem.to_s)
        fOut.write("\n")
      }
    }
  end
end
