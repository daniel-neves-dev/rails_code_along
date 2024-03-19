class ApplicationController < ActionController::Base
  # protect_from_forgery with: :expectation
  before_action :authenticate_user!, except: [:index, :show]
end
