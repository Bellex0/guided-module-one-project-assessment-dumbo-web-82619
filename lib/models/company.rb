class Company < ActiveRecord::Base
    has_many :products
    has_many :trials, through: :products

    def self.tty_prompt
        TTY::Prompt.new
    end

    def self.handle_new_company
        name = self.tty_prompt.ask("What's your company name?") 
        category = self.tty_prompt.ask("What best describes the category of your company?")
        Company.create(name: name, category: category)
    end

    def self.handle_returning_company
        name = self.tty_prompt.ask("Welcome Back! What's your company name?")
        Company.find_by(name: name)
    end

    def list_product
        name = Company.tty_prompt.ask("What's the name of the product?")
        new_pro = Product.create(name: name , brand: self.name, category: self.category)
        binding.pry
    end



end
