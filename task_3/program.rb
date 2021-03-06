
class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station ]
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include? station
  end

  def remove_station(station)
    @stations.delete(station) unless [@stations.first, @stations.last].include? station
  end

  def show_stations
    puts "Маршрут: "
    @stations.each { |station| puts station.name }
  end

end


class Train
  attr_accessor :speed
  attr_reader :current_station_index, :number, :type, :carriages_count

  def initialize(number, type, carriages_count)
    @number = number
    @type = type
    @speed = 0
    @carriages_count = carriages_count
  end
        
  def stop
    @speed = 0
    puts "Поезд остановился"
  end
  
  def add_carriage
    if @speed == 0
      @carriages_count += 1
      puts "К поезду под номером #{@number} подсоединен вагон, всего вагонов #{@carriages_count}"
    else
      puts "Невозможно прицепить вагон во время движения поезда!"
    end
  end
  
  def remove_carriage
    if @speed == 0 && @carriages_count > 0
      @carriages_count -= 1
      puts "От поезда под номером #{@number} отсоединен вагон, всего вагонов #{@carriages_count}"
    elsif(@carriages_count == 0)
      puts "Нечего отцеплять"
    else
      puts "Невозможно отцепить вагон во время движения поезда!"
    end
  end
  
  def prev_station
    @route.stations[@current_station_index - 1]
  end
  
  def next_station
    @route.stations[@current_station_index + 1]
  end
  
  def current_station
    @route.stations[@current_station_index]
  end
      
  def move_forward
    if @speed > 0 && @current_station_index < @route.stations.index(@route.stations.last)
      self.current_station.remove_train(self)
      @current_station_index += 1
      self.current_station.add_train(self)
    else
      puts "Поезд на конечной станции"
    end
  end
  
  def move_back
    if @speed > 0 && @current_station_index > 0
      self.current_station.remove_train(self)
      @current_station_index -= 1
      self.current_station.add_train(self)
    else
      puts "Поезд на начальной станции"
    end
  end
  
  def set_route(route)
    @route = route
    @current_station_index = 0
    puts "Поезду #{@number} установлен новый маршрут следующий #{route.stations.first.name} - #{route.stations.last.name}"
  end
end

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
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
    @trains.each { |train| puts "Поезд №#{train.number} #{train.name} - #{train.type}" }
  end
end

station_start = Station.new('Ладожский вокзал')
station_end = Station.new('Котлас Южный')
station_btw_1 = Station.new('Бабаево')
station_btw_2 = Station.new('Череповец')
station_btw_3 = Station.new('Коноша')

route = Route.new(station_start, station_end)
route.add_station(station_btw_1)
route.add_station(station_btw_2)
route.add_station(station_btw_3)

route.show_stations

train = Train.new(1, 'грузовой', 5)

train.set_route(route)
train.speed = 50
train.move_forward
train.move_forward

train.stop
train.remove_carriage
train.speed = 60

train.move_forward
train.move_forward

train.stop
train.remove_carriage
train.speed = 80
train.move_back