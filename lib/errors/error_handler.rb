# frozen_string_literal: true

module Errors
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActiveRecord::RecordNotFound do |e|
          message = {
            e.model.underscore.downcase.to_sym => "was not found"
          }
          respond(404, message)
        end
        rescue_from ActiveRecord::RecordInvalid do |e|
          respond(422, e.record.errors)
        end
        rescue_from ActiveRecord::RecordNotUnique do |e|
          respond(409, e.to_s)
        end
      end
    end

    def respond(status, messages)
      json = { errors: [messages] }.as_json
      render json: json, status: status
    end
  end
end
