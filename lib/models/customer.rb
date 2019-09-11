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
        puts "You've successfully created an account!"
        sleep 3
        # binding.pry
    end

    def self.handle_returning_customer
        puts "Welcome Back! Please enter your name"
        name = gets.chomp.capitalize
        # name = self.tty_prompt.ask("Welcome back! What is your name?")
        returning = Customer.find_by(name: name)
    end

    def request_new_trial
        product_list = Product.all.map do |product|
            product.name 
        end
        product_request = Customer.tty_prompt.select("So, which one will it be? 🤔", product_list)
        # puts product_list
        sleep 5
        # puts "So, which one will it be? 🤔"
        # response = STDIN.gets.chomp
        # puts response
        puts "Got it. Your trial awaits..."
        chosen = Product.find_by(name: product_request)
        new_trial = Trial.create(customer_id: self.id, product_id: chosen.id, date: Time.now.strftime('%F'))
        # binding.pry
        sleep 1
        puts "Thanks! You will receive your trial in 3 days 📦. Have fun!"
        sleep 3
        return new_trial
        # self.reload
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

    def review_a_product
        if self.all_my_trialed_products.size == 0
            puts "You do not have any current trials."
            sleep 5
            # binding.pry
        else
            product_rev = Customer.tty_prompt.select("Which product would you like to review?", self.product_names)
            the_product_instance = self.all_my_trialed_products.select {| product| product.name == product_rev}
            my_trial = self.trials.select {|trial| trial.product_id == the_product_instance[0].id}
            new_review = Customer.tty_prompt.ask("Tell us what you think!")
            my_trial[0].update(review: new_review)
        end 
        puts "Thanks for your review! Your opinions matter! 🤗"
        sleep 3
    end 

    def cancel_a_trial
        cur_trials_products_names = self.trials.map{|trial|Product.find(trial.product_id)}.map {|product| product.name}
        if cur_trials_products_names.size == 0
            puts "You do not have any current trials."
            sleep 5
        # if self.all_my_trialed_products.size == 0
        #     puts "You do not have any current trials."
        #     # binding.pry
        else
            product_cancel = Customer.tty_prompt.select("Which product would you like to cancel?", self.product_names)
            the_product_instance = self.all_my_trialed_products.select {| product| product.name == product_cancel}
            my_trial = self.trials.select {|trial| trial.product_id == the_product_instance[0].id}  
            Trial.destroy(my_trial[0].id)
            sleep 3
            puts "This trial has been deleted."
            sleep 3
        end 
    end 

    def view_your_trials
        if self.trials.size == 0
            puts "You do not have any current trials."
            sleep 5
        else   
            # puts self.trials 
            cur_trials_products = self.trials.map{|trial|Product.find(trial.product_id)}
            
            # binding.pry

            pro_hash = {}
            cur_trials_products.each do |product|
                pro_hash["#{product.name}"] = product
            end 

            product = Customer.tty_prompt.select("Trials", pro_hash)
            the_trial = Trial.find_by(product_id: product.id)
            if the_trial.nil?
                puts "This trial no longer exists."
            else 
                dates = the_trial.date
                puts product.name + ": " + dates
            end
            sleep 5
            # binding.pry
        end 

    end 






        


end 


