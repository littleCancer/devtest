require 'rails_helper'

RSpec.describe Location, type: :model do

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:secret_code) }

  it { should validate_presence_of(:external_id) }

  it { should have_many(:location_groups).through(:location_relations) }

  describe "external_id uniqueness" do
    subject { Location.new(name: 'Asgard', external_id: 'asg', secret_code: 'a1secret') }
    it { should validate_uniqueness_of(:external_id) }
  end

end
