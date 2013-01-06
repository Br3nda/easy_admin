class Admin::OutboundRequestsController < Admin::BaseController
  before_filter :authorize_outbound_requests

  def index
    @outbound_requests = OutboundRequest.search(params)
    @services = EasyAdmin::OUTBOUND_SERVICES.invert
  end

  def show
    @outbound_request = OutboundRequest.find(params[:id])
  end
end
