# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Branch, type: :model do
  describe 'validations' do
    subject { build :branch }
    it { is_expected.to be_valid }
    it { is_expected.to belong_to :company }
    it { is_expected.to validate_uniqueness_of(:number).scoped_to(:company_id) }
    it { is_expected.to validate_presence_of(:number) }
  end
end
