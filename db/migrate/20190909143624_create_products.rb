class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
    t.string :name
    t.integer :company_id
    t.string :category
    t.string :rating
    end
  end
end
