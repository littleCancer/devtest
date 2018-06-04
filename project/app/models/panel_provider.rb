class PanelProvider < ApplicationRecord

  has_many :target_groups, foreign_key: 'panel_provider_id'

  has_many :countries, foreign_key: 'panel_provider_id'

  has_many :location_groups, foreign_key: 'panel_provider_id'

  has_many :users, foreign_key: 'panel_provider_id'

  validates :code, presence: true, uniqueness: true
end
