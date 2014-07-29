class Site < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_and_belongs_to_many :users

  after_commit :ensure_user_mapping, on: :create

  validates :name, presence: true, uniqueness: true

  private

  def ensure_user_mapping
    users << User.find(owner.id)
  end
end
