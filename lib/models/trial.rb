class Trial < ActiveRecord::Base
    belongs_to :product
    belongs_to :customer
    
    def self.handle_new_trial
        # puts "So, which one will it be?"
        # response = STDIN.gets.chomp
        # puts response
        # puts "Found it. Going to make a trial now."
        # chosen= Product.find_by(name: response)
        # Trial.create(customer_id: customer.id, product_id: chosen.id, date: Time.now.strftime('%F'))
        # binding.pry
    end 
end