class LocationGroup < ApplicationRecord

  belongs_to :country

  has_many :location_relations,  class_name: 'LocationRelation',
           foreign_key: 'location_group_id',
           dependent: :destroy

  has_many :locations, through: :location_relations

  validates :name, presence: true

end
