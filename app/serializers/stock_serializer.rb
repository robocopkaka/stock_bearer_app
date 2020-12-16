# frozen_string_literal: true

# Stock serializer
class StockSerializer < ActiveModel::Serializer
  attributes :id, :name
  
  belongs_to :bearer
end
