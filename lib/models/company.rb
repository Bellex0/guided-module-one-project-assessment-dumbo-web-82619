class Company < ActiveRecord::Base
    has_many :products
    has_many :trials, through: :products

    def self.tty_prompt
        TTY::Prompt.new
    end

    def self.handle_new_company
        name = self.tty_prompt.ask("What is company name?") 
        category = self.tty_prompt.ask("What is company catagory?")
        Company.create(name: name, category: category)
    end

    def self.handle_returning_company
        name = self.tty_prompt.ask("Welcome back! What is your company name?")
        Company.find_by(name: name)
    end

end
