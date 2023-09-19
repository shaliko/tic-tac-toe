# frozen_string_literal: true

# Base class for all controllers (our case all controllers are API controllers)
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def record_not_found
    render json: { error: { message: 'Record not found', type: 'RecordNotFound' } }, status: :not_found
  end

  def parameter_missing(exception)
    render json: { error: { message: exception.message, type: 'ParameterMissing' } }, status: :bad_request
  end
end
