# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :branches, dependent: :destroy

  accepts_nested_attributes_for :branches

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
