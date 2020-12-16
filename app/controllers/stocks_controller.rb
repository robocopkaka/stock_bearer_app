# frozen_string_literal: true

# Stocks controller
class StocksController < ApplicationController
  before_action :find_stock, only: %i[update destroy]

  def create
    stock = Stock.find_by(name: params[:name])
    stock.destroy if stock.present? && stock.bearer_id != params[:bearer_id]

    new_stock = Stock.create!(stock_params)
    json_response(object: new_stock, message: 'Stock created successfully')
  end

  def update
    @stock.update!(name: params[:name])
    json_response(object: @stock, message: 'Stock updated successfully')
  end

  def index
    @stocks = Stock.not_deleted
    json_response(object: @stocks)
  end

  def destroy
    @stock.update!(deleted_at: Time.current)
    json_response(object: @stock, message: 'Stock deleted successfully')
  end

  private

  def find_stock
    @stock = Stock.not_deleted.find_by!(id: params[:id])
  end

  def stock_params
    params.permit(
      :name,
      :bearer_id
    )
  end
end
