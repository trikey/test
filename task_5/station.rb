class Station
  include InstanceCounter
  attr_reader :trains, :name
  @@stations = []
  
  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end
  
  def add_train(train)
    @trains << train
    puts "На станцию #{@name} прибыл #{train.type} поезд под номером #{train.number}"
  end
  
  def remove_train(train)
    @trains.delete(train)
    puts "Со станции #{@name} отбыл #{train.type} поезд под номером #{train.number}"
  end
  
  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end
  
  def show_trains
    @trains.each { |train| puts "Поезд №#{train.number} - #{train.type}" }
  end
end