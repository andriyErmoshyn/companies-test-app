# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :branches, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
