require_relative '../config/environment'

# puts "hello world"

cli = Interface.new

# user_object = 
cli.welcome

# while user_object == nil
#     user_object = cli.welcome
# end

# if user_object.class == Customer 
#     cli.customer = user_object
# else
#     cli.company = user_object
# end

cli.main_menu

binding.pry
0
