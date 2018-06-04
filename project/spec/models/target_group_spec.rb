require 'rails_helper'

RSpec.describe TargetGroup, type: :model do

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:secret_code) }

  it { should have_many(:children).with_foreign_key(:parent_id) }

  it { should belong_to(:parent) }

  it { should have_many(:countries).through(:country_relation) }

end
