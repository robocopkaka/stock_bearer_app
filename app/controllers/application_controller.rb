class ApplicationController < ActionController::API
  include Response
  include Errors::ErrorHandler
end
