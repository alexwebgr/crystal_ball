class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from ActiveRecord::RecordInvalid, with: :rescue_invalid_record
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found

  private

  def rescue_not_found(exception)
    respond_to do |format|
      format.html { render template: 'errors/handle_custom_exception', locals: { message: 'Record not found' }, status: :unprocessable_entity }
      format.json { render json: { message: exception.message }, status: :unprocessable_entity }
    end
  end

  def rescue_invalid_record(exception)
    respond_to do |format|
      format.html { render template: 'errors/handle_custom_exception', locals: { message: exception.message }, status: :unprocessable_entity }
      format.json { render json: { message: exception.message }, status: :unprocessable_entity }
    end
  end

  def handle_custom_exception(exception)
    respond_to do |format|
      format.html { render template: 'errors/handle_custom_exception', locals: { message: exception.message }, status: :unprocessable_entity }
      format.json { render json: { message: exception.message }, status: :unprocessable_entity }
    end
  end

  def render_message(flash_type = :success, status = :ok, message = nil)
    flash.now[flash_type] = message
    render turbo_stream: turbo_stream.append("toast-frame", partial: "partials/toast_container"), status: status
  end
end
