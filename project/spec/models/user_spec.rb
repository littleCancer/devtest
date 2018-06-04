require 'rails_helper'

RSpec.describe User, type: :model do


  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

  describe "email uniqueness" do
    subject { User.new(name: "Thor", email: "thor@asgard.net", password: 'asgard_rules',
                       password_confirmation: 'asgard_rules',
                       panel_provider_id: 1) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

end
