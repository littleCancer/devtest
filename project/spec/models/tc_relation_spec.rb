require 'rails_helper'

RSpec.describe TcRelation, type: :model do

  it { should validate_presence_of(:country_id) }
  it { should validate_presence_of(:target_group_id) }

  it { should belong_to(:country) }
  it { should belong_to(:target_group) }

end
