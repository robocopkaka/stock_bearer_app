# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Stocks spec', type: :request do
  let(:bearer) { create(:bearer) }
  let(:stock_params) { attributes_for(:stock, bearer_id: bearer.id) }

  describe '#create' do
    context 'when valid params are passed' do
      before do
      end
      it 'creates the stock' do
        expect do
          post '/stocks', params: stock_params
        end.to change(Stock, :count).by 1
        returned_stock = json['data']
        expect(returned_stock['name']).to eq stock_params[:name]
      end
    end

    context 'when a duplicate name is entered for the same bearer' do
      before { post '/stocks', params: stock_params }
      it 'returns an error' do
        post '/stocks', params: stock_params
        errors = json['errors']
        expect(errors.first['name']).to include 'has already been taken'
      end
    end

    context 'when bearer ID is changed for a stock' do
      let(:bearer_2) { create(:bearer) }
      before { stock_params[:bearer_id] = bearer_2.id }
      it 'creates a new stock object' do
        expect do
          post '/stocks', params: stock_params
        end.to change(Stock, :count).by 1
      end

      it 'deletes any existing stock with the same name' do
        post '/stocks', params: stock_params
        stocks = Stock.not_deleted.where(name: stock_params[:name])
        expect(stocks.count).to eq 1
      end
    end
  end

  describe '#update' do
    let!(:stock) { create(:stock) }
    context 'when a valid stock ID is passed' do
      context 'when a valid name is passed' do
        before { patch stock_path(stock.id), params: { name: 'Edited name' } }
        it 'updates the stock' do
          returned_stock = json['data']
          expect(returned_stock['name']).to eq 'Edited name'
        end
      end

      context 'when the name has already been taken' do
        let(:stock_2) { create(:stock) }
        before { patch stock_path(stock_2.id), params: { name: stock.name } }
        it 'returns an error' do
          errors = json['errors'].first
          expect(errors['name']).to include 'has already been taken'
        end
      end

      context 'when a bearer id is passed' do
        before { patch stock_path(stock.id), params: stock_params }
        it 'returns an error' do
          errors = json['errors'].first
          expect(errors).to include 'You can\'t change the bearer when updating'
        end
      end
    end

    context 'when an invalid ID is passed' do
      before { patch stock_path(1000), params: { name: 'Edited name' } }
      it 'returns an error' do
        errors = json['errors'].first
        expect(errors['stock']).to include 'was not found'
      end
    end

    context 'when you try to edit a deleted stock' do
      before do
        delete stock_path(stock.id)
        patch stock_path(stock.id), params: { name: 'Edited name' }
      end
      it 'returns an error' do
        errors = json['errors'].first
        expect(errors['stock']).to include 'was not found'
      end
    end
  end

  describe '#destroy' do
    let(:stock) { create(:stock) }
    context 'when a valid ID is passed' do
      before { delete stock_path(stock.id) }
      it 'soft deletes the stock' do
        returned_stock = json['data']
        expect(returned_stock['deleted_at']).to_not be nil
        expect(returned_stock['deleted_at']).to be < Time.current
      end
    end

    context 'when an invalid ID is passed' do
      before { delete stock_path(1000) }
      it 'returns an error' do
        errors = json['errors'].first
        expect(errors['stock']).to include 'was not found'
      end
    end

    context 'when you try to delete an already deleted stock' do
      before do
        2.times { delete stock_path(stock.id) }
      end
      it 'returns an error' do
        errors = json['errors'].first
        expect(errors['stock']).to include 'was not found'
      end
    end
  end

  describe '#index' do
    let!(:stocks) { create_list(:stock, 2) }

    context 'when a request to return all stock items is made' do
      before { get stocks_path }
      it 'returns stocks that haven\'t been deleted' do
        expect(json.count).to eq 2
        expect(json.pluck('deleted_at').uniq).to eq [nil]
      end
    end

    context 'when a stock is deleted' do
      before do
        delete stock_path(stocks.first)
        get stocks_path
      end
      it 'doesn\'t appear in the result' do
        expect(json.count).to eq 1
        expect(json.pluck('id')).to_not include stocks.first.id
      end
    end
    
    context 'pagination' do
      let!(:stocks_2) { create_list(:stock, 13) }
      context 'when there are more than 10 stock items' do
        before { get '/stocks?page=2' }
        it 'moves some to a different page' do
          expect(json.count).to eq 5
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
