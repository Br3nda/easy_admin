class Admin::BaseController < ApplicationController

  private

  def authorize_jobs
    true
    #    redirect_to root_path unless @current_user
  end

end
