class Country < ApplicationRecord
  belongs_to :panel_provider

  has_many :location_groups, foreign_key: 'country_id', dependent: :destroy

  has_many :target_group_relations, class_name: 'TcRelation',
           foreign_key: 'country_id',
           dependent: :destroy

  has_many :target_groups, through: :target_group_relations

  validates :code, presence: true, uniqueness: true
  validates :panel_provider, presence: true
end
