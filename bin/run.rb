require_relative '../config/environment'

puts "hello world"

cli = Interface.new

user_object = cli.welcome

# cli.company = user_object
puts user_object
# puts user_object.name

action = cli.review_or_trial
puts action

binding.pry
0
