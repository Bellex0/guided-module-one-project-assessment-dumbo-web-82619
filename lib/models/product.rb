class Product < ActiveRecord::Base
    has_many :trials
    has_many :customers, through: :trials
    belongs_to :company

    
end