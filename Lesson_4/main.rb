#!/usr/bin/env ruby
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'station'
require_relative 'route'


welcome_msg = <<msg

===== WELCOME =====
Enter 1 if you want to create something
Enter 2 if you want to change something
Enter 3 if you want to see the status of something
Enter another key to exit
msg

create_msg = <<msg

===== WELCOME =====
Enter 1 if you want to create a station
Enter 2 if you want to create a route
Enter 3 if you want to create a train
Enter another key to exit
msg

edit_msg = <<msg

===== WELCOME =====
Enter 1 if you want to add the station to the route
Enter 2 if you want to remove the station from the route
Enter 3 if you want to move the train forward
Enter 4 if you want to move the train backward
Enter another key to exit
msg

status_msg = <<msg

===== WELCOME =====
Enter 1 if you want to see
Enter 2 if you want to change something
Enter 3 if you want to see the status of something
Enter another key to exit
msg

# print welcome_msg
# choise = gets.chomp
# case choise
# when "1"
#   print create_msg
# when "2"
#   print edit_msg
# when "3"
#   print status_msg
# else
#   puts 'Bye!'
#   exit
# end
