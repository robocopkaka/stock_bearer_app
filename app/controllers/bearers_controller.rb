# frozen_string_literal: true

# Bearers controller
class BearersController < ApplicationController
  def create
    bearer = Bearer.create!(name: params[:name])
    json_response(object: bearer, message: 'Bearer created successfully')
  end
end
