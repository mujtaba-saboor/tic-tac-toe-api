# frozen_string_literal: true

# ApiExceptionModule contains error handling
module ApiExceptionModule
  extend ActiveSupport::Concern

  class InvalidAuthToken < StandardError; end

  class InvalidTile < StandardError; end

  class GameCompleted < StandardError; end

  included do
    # rescue_from Exception, with: :internal_server_error
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ApiExceptionModule::InvalidAuthToken, with: :unauthorized
    rescue_from ApiExceptionModule::InvalidTile, with: :unprocessable_entity
    rescue_from ApiExceptionModule::GameCompleted, with: :game_completed
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from CanCan::AccessDenied, with: :unauthorized
  end

  private

  # Status code 422 - unprocessable entity
  def unprocessable_entity(error)
    format_json_response({ error_message: error.message }, :unprocessable_entity)
  end

  # Status code 401 - unauthorized
  def unauthorized(error)
    format_json_response({ error_message: error.message }, :unauthorized)
  end

  # Status code 404 - resoruce not found
  def not_found(error)
    format_json_response({ error_message: error.message }, :not_found)
  end

  def game_completed(error)
    format_json_response({ game_completed: true, error_message: error.message }, :unauthorized)
  end

  # Status code 500 - internal server error
  def internal_server_error(_error)
    format_json_response({ error_message: I18n.t(:something_went_wrong) }, :internal_server_error)
  end
end
