# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Turn, type: :model do
  subject { build(:turn) }

  it { should validate_presence_of(:tile_type) }
  it { should validate_presence_of(:tile_position) }
  it { should validate_inclusion_of(:tile_position).in_range(1..9) }
  it { should validate_numericality_of(:tile_type) }
end
