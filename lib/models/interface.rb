
class Interface
    attr_reader :prompt
    attr_accessor :customer, :company, :product, :trial, :path

    def initialize()
        @prompt = TTY::Prompt.new
    end

    def welcome
        system "clear"
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
                menu.choice "Exit"
            end 
            case choice1
            when "New Customer"
                choice3 = self.prompt.select("Sign up to unlock the fun! 🎉") do |menu|
                    menu.choice "Sign Up"
                    menu.choice "Exit"
                end 
                case choice3
                when "Sign Up"
                    self.customer = Customer.handle_new_customer
                when "Exit"  
                    self.welcome  
                end
                
            when "Returning Customer"
                choice3 = self.prompt.select("Log in here,stranger") do |menu|
                    menu.choice "Log In"
                    menu.choice "Exit"
                end 
                case choice3
                when "Log In"
                    self.customer = Customer.handle_returning_customer
                when "Exit"  
                    self.welcome  
                end
                
            when "Exit"
                self.welcome
            end 
        
        when "Company"
            @path = "Company"
            choice2 = self.prompt.select("New Company or Returning Company?") do |menu|
                menu.choice "New Company"
                menu.choice "Returning Company"
                menu.choice "Exit"
            end 
            case choice2
            when "New Company"
                self.company = Company.handle_new_company
            when "Returning Company"
                self.company = Company.handle_returning_company
            when "Exit"
                self.welcome
            end 
            
        end 



    end 

    def main_menu
            system "clear"
            if @path == "Customer"
                choice = self.prompt.select("What's good for today? ") do |menu|
                    menu.choice "Request a new product trial"
                    menu.choice "Review a product"
                    menu.choice "Cancel a product trial"
                    menu.choice "View your trials"
                    menu.choice "Exit"
                end


                case choice   
                # if you request a trial, then view your trials, it is NOT there!!!
                when "Request a new product trial"
                    self.customer.request_new_trial
                    self.main_menu

                when "Review a product"
                    self.customer.review_a_product
                    self.main_menu

                when "Cancel a product trial"
                    self.customer.cancel_a_trial
                    self.main_menu
                when "View your trials"
                    self.customer.view_your_trials
                    sleep 5
                    self.main_menu
                when "Exit"
                    self.welcome
                end
            elsif @path == "Company"
                choice = self.prompt.select("What's your task for today?") do |menu|
                    menu.choice "List a new product"
                    menu.choice "See all your current products"
                    menu.choice "Update a listing"
                    menu.choice "Exit"
                end 
            end
            case choice 
            when "List a new product"
                self.company.list_product
                puts "Your listing has been added."
                sleep 5
                self.main_menu
            when "See all your current products"
                self.company.see_cur_products
                self.main_menu
            when "Update a listing"
                self.company.update_a_list
                self.main_menu
            when "Exit"
                self.welcome
            end
    end

end 


