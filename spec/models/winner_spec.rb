require 'rails_helper'

RSpec.describe Winner, type: :model do
  it { should validate_presence_of(:won_by) }
end
