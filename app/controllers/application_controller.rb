# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    respond_to do |format|
      format.json { render json: {error: 'Record not found'}, status: :not_found }
      format.html { redirect_to root_path, alert: 'Record not found' }
    end
  end
end
