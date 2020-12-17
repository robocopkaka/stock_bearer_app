# frozen_string_literal: true

# Stocks controller
class StocksController < ApplicationController
  before_action :find_stock, only: %i[update destroy]
  before_action :check_bearer_exists, only: %i[update]

  def create
    stock = Stock.not_deleted.find_by(name: params[:name])
    if stock.present? && stock.bearer_id != params[:bearer_id].to_i
      stock.update!(deleted_at: Time.current)
    end

    new_stock = Stock.create!(stock_params)
    json_response(object: new_stock, message: 'Stock created successfully')
  end

  def update
    @stock.update!(name: params[:name])
    json_response(object: @stock, message: 'Stock updated successfully')
  end

  def index
    @stocks = Stock.not_deleted.page
    paginate @stocks, per_page: 10
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

  def check_bearer_exists
    return unless params[:bearer_id]

    raise "You can't change the bearer when updating"
  end

  def pagination_meta(object)        {
    current_page: object.current_page,
    next_page: object.next_page,
    prev_page: object.prev_page,
    total_pages: object.total_pages,
    total_count: object.total_count        }
  end
end
