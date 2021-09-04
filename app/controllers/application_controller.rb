class ApplicationController < ActionController::Base
  def render_json_errors(errors, status: :unprocessable_entity)
    render json: ErrorSerializer.serialize(errors), status: :status
  end
end
