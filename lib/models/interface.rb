
class Interface
    attr_reader :prompt
    attr_accessor :customer, :company, :product, :trial, :path

    def initialize()
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "Hey! Welcome to Sample Hamper! Try out new and best-selling products without the commitment! 🙌"
        choice = self.prompt.select("Customer or Company?") do |menu|
            menu.choice "Customer"
            menu.choice "Company"
        end 

        case choice
        when "Customer"
            @path = "Customer"
            choice1 = self.prompt.select("New Customer or Returning Customer?") do |menu|
                menu.choice "New Customer"
                menu.choice "Returning Customer"
            end 
            case choice1
            when "New Customer"
                self.customer = Customer.handle_new_customer
            when "Returning Customer" # this is not working!!!
                self.customer = Customer.handle_returning_customer
            end 
        
        when "Company"
            @path = "Company"
            choice2 = self.prompt.select("New Company or Returning Company?") do |menu|
                menu.choice "New Company"
                menu.choice "Returning Company"
            end 
            case choice2
            when "New Company"
                self.company = Company.handle_new_company
            when "Returning Company"
                self.company = Company.handle_returning_company
            end 
            
        end 



    end 

    def main_menu
            # system "clear"
            if @path == "Customer"
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
                    sleep 5
                    puts "So, which one will it be? 🤔"
                    response = STDIN.gets.chomp
                    puts response
                    puts "Got it. Your trial awaits..."
                    chosen = Product.find_by(name: response)
                    new_trial = Trial.create(customer_id: self.customer.id, product_id: chosen.id, date: Time.now.strftime('%F'))
                    # binding.pry
                    sleep 2
                    puts "Thanks! You will receive your trial in 3 days 📦. Have fun!"
                    self.review_or_trial

                when "Review a product"
                    # # this customer's all trails' products
                    aa = self.customer.all_my_trialed_products
                    puts self.customer.product_names
                    response = self.prompt.ask("Which product would you like to review?")
                    the_product_instance = aa.select {| product| product.name == response}
                    my_trial = self.customer.trials.select {|trial| trial.product_id == the_product_instance[0].id}
                    new_review = self.prompt.ask("Tell us what you think!")
                    my_trial[0].review = new_review
                    puts "Thanks for your review! Your opinions matter! 🤗"
                    # binding.pry

                when "exit"
                end
            elsif @path == "Company"
                choice = self.prompt.select("What's your task for today?") do |menu|
                    menu.choice "List a new product"
                    menu.choice "See all your current products"
                    menu.choice "See all your reviews"
                    menu.choice "exit"
                end 
            end
            case choice 
            when "List a new product"
                self.company.list_product
            when "See all your current products"
                self.company.products
                binding.pry
            end
    end

end 


