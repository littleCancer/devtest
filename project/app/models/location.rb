class Location < ApplicationRecord

  has_many :location_relations, class_name: 'LocationRelation',
           foreign_key: 'location_id',
           dependent: :destroy
  has_many :location_groups, through: :location_relations

  validates :name, presence: true
  validates :external_id, presence: true, uniqueness: true
  validates :secret_code, presence: true
end
