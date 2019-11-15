class Organisation < ApplicationRecord
	validates_presence_of :name
	validates_uniqueness_of :name
	validates :hourly_rate, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
	has_many :users,dependent: :destroy
	has_many :shifts,dependent: :destroy
end
