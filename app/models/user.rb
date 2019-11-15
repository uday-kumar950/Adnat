class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates_presence_of :name
  belongs_to :organisation, optional: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :shifts,dependent: :destroy       
end
