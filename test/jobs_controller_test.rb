require 'test_helper'

class Admin::JobsControllerTest < ActionController::TestCase
  setup do
    @job = Delayed::Job.create
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  test "should get show" do
    get :show, id: @job.id
    assert_response :success
    assert_not_nil assigns(:job)
  end

  test "should retry job" do
    @job.update_column :attempts, 5
    assert_equal 5, @job.reload.attempts

    post :retry, id: @job.id
    assert_redirected_to admin_jobs_path
    assert_equal 0, @job.reload.attempts
  end

  test "should delete job" do
    delete :destroy, id: @job.id
    assert_redirected_to admin_jobs_path
    assert_nil Delayed::Job.find_by_id @job.id
  end
end
