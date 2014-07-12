class User < ActiveRecord::Base
  has_and_belongs_to_many :sites

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :applications, class_name: 'Doorkeeper::Application', as: :owner
end
