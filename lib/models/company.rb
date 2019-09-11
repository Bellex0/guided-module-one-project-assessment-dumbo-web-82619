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
        # company.reload
    end

    def self.handle_returning_company
        name = self.tty_prompt.ask("Welcome Back! What's your company name?")
        Company.find_by(name: name)
    end

    def list_product
        name = Company.tty_prompt.ask("What's the name of the product?")
        new_pro = Product.create(name: name , company_id: self.id, category: self.category)
        # puts new_pro
        # return new_pro
        # binding.pry
    end

    def cur_products_names
        self.products.map {|product| product.name}
    end 

    def cur_products_ids
        self.products.map {|product| product.id}
    end 

    def see_cur_products
        if self.products.size == 0
            puts "You do not have any listings at this time."
            sleep 5
        else
            products_instances = cur_products_ids.map do |id|
                Product.find(id)
            end 
            # binding.pry
            pro_hash = {}
            products_instances.each do |product|
                pro_hash["#{product.name}"] = product  
                # binding.pry
            end 
            product_choice = Company.tty_prompt.select("Products", pro_hash)
            puts "Name: " + product_choice.name
            puts "Category: " +  product_choice.category
            sleep 4
        end 
    end 

    def update_a_list
        if self.products.size == 0
            puts "You do not have any listings at this time."
            sleep 5
        else 
            # products_instances = cur_products_names.map do |name|
            #     Product.find_by(name: name)
            # end 
            products_instances = cur_products_ids.map do |id|
                Product.find(id)
            end 

            pro_hash = {}
            products_instances.each do |product|
                pro_hash["#{product.name}"] = product  
            end 

            product_choice = Company.tty_prompt.select("Products", pro_hash)

            name_or_cat = ["name", "category"]
            change = Company.tty_prompt.select("What do you want to change?", name_or_cat)

            update = Company.tty_prompt.ask("What do you want to change it to?")

            updated = product_choice.update(name: update)

            puts "Your product has been updated."
            sleep 3
            return updated
            # self.reload
            # binding.pry
        end 

        # product_choice = Company.tty_prompt.select("Products", self.)

        
    end 
    

    def cur_products_trials
        my_products_trials = self.products.map {|product| Trial.find_by(product_id: product.id)}.select {|trial| trial.nil? != true}
    end 
        



end
