class Admin::BaseController < ApplicationController

  private

  def authorize_jobs
    true
  end

end
