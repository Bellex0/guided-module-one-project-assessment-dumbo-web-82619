class CreateTrials < ActiveRecord::Migration[5.2]
  def change
    create_table :trials do |t|
    t.integer :customer_id
    t.integer :product_id  
    t.string :date
    t.string :review
    end
  end
end
