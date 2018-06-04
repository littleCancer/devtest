require 'rails_helper'

RSpec.describe Country, type: :model do


  it  { should have_many(:location_groups).with_foreign_key(:country_id)
                   .dependent(:destroy) }

  it { should have_many(:target_groups).through(:target_group_relations) }

  it { should validate_presence_of(:code)}

  it { should validate_presence_of(:panel_provider)}

  describe "code uniqueness" do
    subject { Country.new(code: 'asg', panel_provider_id: 1) }
    it { should validate_uniqueness_of(:code) }
  end

end
