class Product < ActiveRecord::Base
	validates :name, presence: true
	validates :description, presence: true
	
	belongs_to :category
	has_many :comments
end
