class TargetGroup < ApplicationRecord

  has_closure_tree

  belongs_to :panel_provider

  has_many :country_relation, class_name: 'TcRelation',
           foreign_key: 'country_id',
           dependent: :destroy

  has_many :countries, through: :country_relation

  scope :roots, -> { where(parent_id: nil) }

  validates :name, presence: true
  validates :secret_code, presence: true

end
