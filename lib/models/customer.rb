class Customer < ActiveRecord::Base
    has_many :trials
    has_many :products, through: :trials

    def self.tty_prompt
        TTY::Prompt.new
    end

    def self.handle_new_customer
        name = self.tty_prompt.ask("What is name?")
        age = self.tty_prompt.ask("What is age?")
        location = self.tty_prompt.ask("What is location?")
        Customer.create(name: name , age: age, location: location)
    end

    def self.handle_returning_customer
        name = self.tty_prompt.ask("Welcome back! What is your name?")
        Customer.find_by(name: name)
    end


end 


