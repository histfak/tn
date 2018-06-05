#!/usr/bin/env ruby
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'station'
require_relative 'route'

class Main
  def initialize
    @stations = {}
    @routes = {}
    @trains = {}
    @carriages = {}
  end

  SEP = ', use space as a separator: '

  def start
    welcome_msg = <<msg

===== WELCOME =====
Enter 1 to create a station
Enter 2 to create a route
Enter 3 to create a train
Enter 4 to create a carriage
===================
Enter 5 to add the station to the route
Enter 6 to remove the station from the route
Enter 7 to assign the route to the train
Enter 8 to move the train forward
Enter 9 to move the train backward
Enter 10 to add a carriage
Enter 11 to remove a carriage
===================
Enter 12 to see the list of stations of the route
Enter 13 to see the list of trains in the station
Enter another key to exit
msg

    print welcome_msg

    loop do
      choice = gets.chomp
      case choice
      when 1
        ui_create_station
      when 2
        ui_create_route
      when 3
        ui_create_train
      when 4
        ui_create_carriage
      when 5
        ui_add_station
      when 6
        ui_remove_station
      when 7
        ui_assign_route
      when 8
        ui_move_forward
      when 9
        ui_move_backward
      when 10
        ui_add_carriage
      when 11
        ui_remove_carriage
      when 12
        ui_list_stations
      when 13
        ui_trains_status
      else
        exit
      end
    end
  end

  # 1
  def ui_create_station
    puts 'Enter the name of the station: '
    name = gets.chomp
    station = Station.new(name)
    @stations[station] = station.object_id
  end

  # 2
  def ui_create_route
  end

  # 3
  def ui_create_train
  end

  # 4
  def ui_create_carriage
  end

  # 5
  def ui_add_station
  end

  # 6
  def ui_remove_station
  end

  # 7
  def ui_assign_route
  end

  # 8
  def ui_move_forward
  end

  # 9
  def ui_move_backward
  end

  # 10
  def ui_add_carriage
  end

  # 11
  def ui_remove_carriage
  end

  # 12
  def ui_list_stations
  end

  # 13
  def ui_trains_status
  end
end
