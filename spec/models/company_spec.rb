# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    subject { build :company }
    it { is_expected.to be_valid }
    it { is_expected.to have_many :branches }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'not_archived scope' do
    it 'does not include arhived companies' do
      expect(Company.not_archived.to_sql).to eq Company.where.not(archived: true).to_sql
    end
  end

  describe 'recently_updated scope' do
    it 'orders by updated_at: :desc' do
      expect(Company.recently_updated.to_sql).to eq Company.order(updated_at: :desc).to_sql
    end
  end
end
