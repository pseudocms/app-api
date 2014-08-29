class SiteSerializer < Api::Serializer
  attributes :id, :name, :description, :created_at, :updated_at
  belongs_to :owner
end
