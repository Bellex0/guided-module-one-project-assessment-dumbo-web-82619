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
        # binding.pry
        name = self.tty_prompt.ask("Hello again 😺 ! What's your company name?")
        Company.find_by(name: name)
    end

    def list_product
        name = Company.tty_prompt.ask("What's the name of the product?")
        new_pro = Product.create(name: name , company_id: self.id, category: self.category)

        spinner = TTY::Spinner.new("[:spinner] Work in progress ...", format: :pulse_2)
        spinner.auto_spin
        sleep(2)
        spinner.stop('Thank you. Your product has been listed. 🤗') 
        sleep 3
    end

    def cur_products_names
        self.products.map {|product| product.name}
    end 

    def cur_products_ids
        self.reload.products.map {|product| product.id}
    end 

    def see_cur_products
        # binding.pry
        if self.reload.products.size == 0
            puts "You do not have any listings at this time."
                sleep 5
        else
            products_instances = cur_products_ids.map do |id|
                Product.find(id)
            end 
            pro_hash = {}
            products_instances.each do |product|
                pro_hash["#{product.name}"] = product  
                # binding.pry
            end 
            product_choice = Company.tty_prompt.select("Products", pro_hash)
            if product_choice.rating.nil?
                puts "Name: " + product_choice.name
                puts "Category: " +  product_choice.category
            elsif 
                puts "Name: " + product_choice.name
                puts "Category: " +  product_choice.category
                puts "Rating: " + product_choice.rating
            end 
                # puts product.name + ": " + dates + "  Review: " +review
            sleep 4
        end 
    end 

    def update_a_list
        if self.reload.products.size == 0
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

            product_choice = Company.tty_prompt.select("Your goodies", pro_hash)

            name_or_cat = ["Name", "Category"]
            change = Company.tty_prompt.select("Which do you want to change?", name_or_cat)

            update = Company.tty_prompt.ask("What do you want to change it to?")

            updated = product_choice.update(name: update)

            spinner = TTY::Spinner.new("[:spinner] Work in progress ...", format: :pulse_2)
            spinner.auto_spin
            sleep(2)
            spinner.stop('Thank you. Your product has been updated. 🤗') 
            sleep 3

            return updated
            # self.reload
            # binding.pry
        end 
        
    end 

    def cur_products_trials
        my_products_trials = self.reload.products.map {|product| Trial.find_by(product_id: product.id)}.select {|trial| trial.nil? != true}
    end 
        
    def remove_product
        if self.reload.products.size == 0
            puts "You do not have any listings at this time."
                sleep 5
        else
            products_instances = cur_products_ids.map do |id|
                Product.find(id)
            end 

            pro_hash = {}
            products_instances.each do |product|
                pro_hash["#{product.name}"] = product  
            end 

            product_choice = Company.tty_prompt.select("Which product do you want to remove?", pro_hash)
            
            Product.destroy(product_choice.id)
            # when you destroy a product, you also need to destroy all the related trials of it.
            if product_choice.trials.size != 0
                # binding.pry
                Trial.destroy(Trial.find_by(product_id: product_choice.id))
            end 
            
            bar = TTY::ProgressBar.new("Bye bye 👋 .. [:bar]", total: 30)
            30.times do
                sleep(0.1)
                bar.advance(1)
            end 
            puts "This product and its related trials have been deleted."
            sleep 3
        end 
    end 



end
