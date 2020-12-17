# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bearers request spec', type: :request do
  let(:bearer_params) { attributes_for(:bearer) }
  let(:bearer) { create(:bearer) }
  
  describe '#create' do
    context 'when valid params are passed' do
      it 'creates a bearer' do
        expect do
          post bearers_path, params: bearer_params
        end.to change(Bearer, :count).by 1
        returned_bearer = json['data']
        expect(returned_bearer['name']).to eq bearer_params[:name]
      end
    end
    
    context 'when name has already been taken' do
      before { post bearers_path, params: { name: bearer.name } }
      it 'returns an error' do
        errors = json['errors'].first
        expect(errors['name']).to include 'has already been taken'
      end
    end
  end
end
