class Admin::BaseController < ApplicationController

  private

  def authorize_jobs
    true
    #    redirect_to root_path unless @current_user
  end

  def authorize_outbound_requests
    true
  end

end
