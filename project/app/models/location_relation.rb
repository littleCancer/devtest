class LocationRelation < ApplicationRecord

  belongs_to :location
  belongs_to :location_group

  validates :location_id, presence: true
  validates :location_group_id, presence: true

end
