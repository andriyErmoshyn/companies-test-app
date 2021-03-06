# frozen_string_literal: true

class Branch < ApplicationRecord
  belongs_to :company
  validates :number, presence: true, uniqueness: { scope: :company_id }
end
