class ApplicationController < ActionController::Base
  protected

  def render_json_errors(errors, status: :unprocessable_entity)
    render json: ErrorSerializer.serialize(errors), status: :status
  end

  def underscore_params!
    params.deep_transform_keys!(&:underscore)
  end
end
