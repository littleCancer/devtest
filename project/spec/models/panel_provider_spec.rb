require 'rails_helper'

RSpec.describe PanelProvider, type: :model do

  it { should validate_presence_of(:code) }

  describe "code uniqueness" do
    subject { PanelProvider.new(code: "pan1") }
    it { should validate_uniqueness_of(:code) }
  end


  it { should have_many(:target_groups).with_foreign_key('panel_provider_id') }

  it { should have_many(:countries).with_foreign_key('panel_provider_id') }

  it { should have_many(:location_groups).with_foreign_key('panel_provider_id') }

  it { should have_many(:users).with_foreign_key('panel_provider_id') }

end
