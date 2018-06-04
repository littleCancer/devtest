require 'rails_helper'

RSpec.describe LocationRelation, type: :model do

  it { should validate_presence_of(:location_id) }
  it { should validate_presence_of(:location_group_id) }

  it { should belong_to(:location) }
  it { should belong_to(:location_group) }

end
