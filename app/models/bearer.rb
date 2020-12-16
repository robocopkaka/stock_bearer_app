# frozen_string_literal: true

# Bearer model
class Bearer < ApplicationRecord
  has_many :stocks
  validates_uniqueness_of :name, { case_sensitive: false }
end
