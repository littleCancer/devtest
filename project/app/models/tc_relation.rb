class TcRelation < ApplicationRecord

  validates :country_id, presence: :true
  validates :target_group_id, presence: :true

  belongs_to :country
  belongs_to :target_group
  accepts_nested_attributes_for :target_group,
                                :reject_if => lambda { |a| a[:parent_id].present? }

end
