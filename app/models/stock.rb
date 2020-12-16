# frozen_string_literal: true

# Stock model
class Stock < ApplicationRecord
  belongs_to :bearer

  validates_uniqueness_of :name, { case_sensitive: false }

  scope :not_deleted, -> { where(deleted_at: nil) }
end
