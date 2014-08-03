class Admin::JobsController < Admin::BaseController
  before_filter :authorize_jobs

  def index
    @jobs = Delayed::Job.order(:run_at)
  end

  def show
    @job = Delayed::Job.find(params[:id])
  end

  def destroy
    if @job = Delayed::Job.find_by_id(params[:id])
      @job.destroy
    end
    redirect_to admin_jobs_path, :notice => "Job deleted"
  end

  def retry
    if @job = Delayed::Job.find_by_id(params[:id])
      @job.update_columns(attempts: 0, run_at: Time.now, failed_at: nil)
    end
    redirect_to admin_jobs_path, :notice => "Job will be retried"
  end
end
