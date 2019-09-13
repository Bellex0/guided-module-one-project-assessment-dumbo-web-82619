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
        ncus
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
        sleep 5
        # puts "So, which one will it be? 🤔"
        # response = STDIN.gets.chomp
        # puts response
        chosen = Product.find_by(name: product_request)
        new_trial = Trial.create(customer_id: self.id, product_id: chosen.id, date: Time.now.strftime('%F'))
        # binding.pry
        bar = TTY::ProgressBar.new("Got it. Your trial awaits... [:bar]", total: 30)
        30.times do
            sleep(0.1)
            bar.advance(1)
        end
        puts "Thanks! You will receive your trial in 3 days 📦. Have fun!"
        sleep 5
        return new_trial
    end

    # we dont need this one anymore because it equals to self.reload.products 
    # def all_my_trialed_products
    #     self.trials.map do |trial|
    #             Product.find(trial.product_id)
    #         end
    # end
    
    def product_names
        self.reload.products.map do |product|
                product.name
        end
    end

    def review_a_product
        if self.reload.products.size == 0
            puts "You do not have any current trials."
            sleep 5
            # binding.pry
        else
            product_rev = Customer.tty_prompt.select("Which product would you like to review?", self.product_names)
            the_product_instance = self.products.select {| product| product.name == product_rev}
            my_trial = self.trials.select {|trial| trial.product_id == the_product_instance[0].id}
            new_review = Customer.tty_prompt.ask("Tell us what you think!")
            my_trial[0].update(review: new_review)

            spinner = TTY::Spinner.new("[:spinner] Scribbling ...", format: :pulse_2)
            spinner.auto_spin # Automatic animation with default interval
            sleep(2)
            spinner.stop('Thanks for your review! Your opinions matter! 🤗') # Stop animation
            # puts "Thanks for your review! Your opinions matter! 🤗"
            sleep 3
        end 
        
    end 

    def cancel_a_trial
        # cur_trials_products_names = self.reload.trials.map{|trial|Product.find(trial.product_id)}.map {|product| product.name}

        if self.product_names.size == 0
            puts "You do not have any current trials."
            sleep 5
        else
            product_cancel = Customer.tty_prompt.select("Which product would you like to cancel?", self.product_names)
            the_product_instance = self.reload.products.select {| product| product.name == product_cancel}
            my_trial = self.trials.select {|trial| trial.product_id == the_product_instance[0].id}  
            
            Trial.destroy(my_trial[0].id)
            
            bar = TTY::ProgressBar.new("Deleting.. [:bar]", total: 30)
            30.times do
                sleep(0.1)
                bar.advance(1)
            end
            puts "This trial has been deleted."
            sleep 3
        end 
    end 

    def view_your_trials
        # binding.pry
        if self.reload.trials.size == 0
            puts "You do not have any current trials."
            sleep 3
        else   
            # self.reload.products
            cur_trials_products = self.reload.products
            # .map{|trial|Product.find(trial.product_id)}
            
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
            sleep 3
            # binding.pry
        end 

    end 






        


end 


