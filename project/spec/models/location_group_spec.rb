require 'rails_helper'

RSpec.describe LocationGroup, type: :model do

  it { should validate_presence_of(:name) }

  it { should belong_to(:country) }

  it { should have_many(:locations).through(:location_relations) }

end
