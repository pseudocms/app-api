class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :applications, class_name: 'Doorkeeper::Application', as: :owner
  has_and_belongs_to_many :sites
  has_many :owned_sites, class_name: 'Site'
end
