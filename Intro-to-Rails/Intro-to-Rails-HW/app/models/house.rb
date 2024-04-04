class House < ApplicationRecord
    has_many :residents, class_name: 'Person', foreign_key: 'house_id'
    validates :address, presence: true
  end
  
