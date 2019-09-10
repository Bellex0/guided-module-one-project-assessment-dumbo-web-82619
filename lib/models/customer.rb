class Customer < ActiveRecord::Base
    has_many :trials
    has_many :products, through: :trials

    def self.tty_prompt
        TTY::Prompt.new
    end

    def self.handle_new_customer
        name = self.tty_prompt.ask("What's your name?")
        age = self.tty_prompt.ask("Age?")
        location = self.tty_prompt.ask("Location?")
        new_cus = Customer.create(name: name , age: age, location: location)
        ncus = Customer.find_by(name: new_cus.name)
        binding.pry
    end

    def self.handle_returning_customer
        puts "Welcome Back! Please enter your name"
        name = gets.chomp.capitalize
        # name = self.tty_prompt.ask("Welcome back! What is your name?")
        returning = Customer.find_by(name: name)
    end

    def all_my_trialed_products
        self.trials.map do |trial|
                Product.find(trial.product_id)
            end
    end

    def product_names
        my_products = all_my_trialed_products.map do |product|
                product.name
        end
    end





        


end 


