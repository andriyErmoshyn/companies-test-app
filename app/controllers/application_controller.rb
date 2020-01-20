# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordInvalid do |error|
    json_response({ message: error.message }, :unprocessable_entity)
  end

  rescue_from ActiveRecord::RecordNotUnique do
    json_response({ message: 'Uniqueness validation violation' }, :unprocessable_entity)
  end

  rescue_from ActiveRecord::RecordNotFound do
    json_response({ message: 'Record not found' }, :not_found)
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
