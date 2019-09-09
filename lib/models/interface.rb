class Interface
    attr_reader :prompt
    attr_accessor :customer, :company, :product, :trial

    def initialize()
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "Hey! Welcome to Sample hamper!"
        choice = self.prompt.select("Customer or company?") do |menu|
            menu.choice "Customer"
            menu.choice "Company"
        end 

        case choice
        when "Customer"
            choice1 = self.prompt.select("New Customer or returning customer?") do |menu|
                menu.choice "New Customer"
                menu.choice "Returning customer"
            end 
            case choice1
            when "New Customer"
                @cur_new_cus = Customer.handle_new_customer
            when "Returning Customer" # this is not working!!!
                @cur_cus = Customer.handle_returning_customer
            end 
        
        when "Company"
            choice2 = self.prompt.select("New Company or returning company?") do |menu|
                menu.choice "New Company"
                menu.choice "Returning Company"
            end 
            case choice2
            when "New Company"
                Company.handle_new_company
            when "Returning Company"
                Company.handle_returning_company
            end 
            
        end 



    end 

    def review_or_trial
            system "clear"
            choice = self.prompt.select("What's good for today?") do |menu|
                menu.choice "Request a new product trial"
                menu.choice "Review a product"
                menu.choice "exit"
            end
            case choice 
            when "Request a new product trial"
                product_list = Product.all.map do |product|
                    product.name 
                end
                puts product_list
                sleep 10
                puts "So, which one will it be?"
                response = STDIN.gets.chomp
                puts response
                puts "Found it. Going to make a trial now."
                chosen = Product.find_by(name: response)
                # binding.pry # We dont know how to pick the current customer instance!!!
                Trial.create(customer_id: @cur_new_cus.id, product_id: chosen.id, date: Time.now.strftime('%F'))
                puts "Thanks! You will receive your trial in 3 days."
                self.review_or_trial

            when "Review a product"
                # this customer's all trails' products
                all_trialed_products = self.customer.trials.map do |trial|
                    Product.find(trial.product_id)
                end
                # this customer's all trails' products names
                puts all_trialed_products_names = self.customer.trials.map do |trial|
                    Product.find(trial.product_id).name
                end
                puts "Which one you want to review?"
                response1 = STDIN.gets.chomp
                puts response1

                the_product =  all_trialed_products.find_by(name: response1)
                the_trial = self.customer.trials.select {|trial| trial.product_id == the_product.id}
                
                puts "Write your review"
                response2 = STDIN.gets.chomp
                the_trial.review = response2
                
                puts the_trial
                puts "Thanks for your review!"
                binding.pry

            when "exit"
            end
        end



end 


