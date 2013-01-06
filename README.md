# EasyAdmin

A Rails engine containing common admin maintenance screens.
Currently contains Delayed::Job and Outbound Request maintenance screens

## Installation

Add this line to your application's Gemfile:

    gem 'easy_admin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_admin

## Usage

The gem contains a dummy rails apps (under test/dummy) which you can use to test or extend the functionality (contains no styles!).

To use it in your Rails app, all you need is a Admin::BaseController (which the EasyAdmin controllers will extend). Define any authentication, layout and before_filter logic in there.

### Delayed::Jobs
To manage Delayed::Jobs, you need to define a method in your Admin::BaseController called authorize_jobs which will control access to the JobsController.

    class Admin::BaseController < ApplicationController
      layout 'admin'

      private

      def authorize_jobs
        redirect_to root_path unless @current_user.admin?
      end
    end

You will get the following routes:

    retry_admin_job POST   /admin/jobs/:id/retry(.:format)          admin/jobs#retry
         admin_jobs GET    /admin/jobs(.:format)                    admin/jobs#index
          admin_job GET    /admin/jobs/:id(.:format)                admin/jobs#show
                    DELETE /admin/jobs/:id(.:format)                admin/jobs#destroy

### Outbound Requests
#### Setup
To manage OutboundRequests you need to define a method in your Admin::BaseController called authorize_outbound_requests which will controll access to the OutboundRequestsController.

    class Admin::BaseController < ApplicationController
      layout 'admin'

      private

      def authorize_outbound_requests
        redirect_to root_path unless @current_user.admin?
      end
    end

You will need to run this for generating the outbound_request create table migration:
    $ rails g easy_admin:active_record

The outbound_requests model will have the following attributes:
    :service
    :action
    :identifier
    :params
    :response_code
    :response_body
    :error
    :created_at
    :updated_at

You also need to define the outbound services as a hash constant. Put this in an EasyAdmin module in application.rb.
    module ::EasyAdmin
      OUTBOUND_SERVICES = {webhook: 'Webhook', sailthru: 'Sailthru'}
    end

You will get the following routes:
    admin_outbound_requests GET    /admin/outbound_requests(.:format)     admin/outbound_requests#index
    admin_outbound_request GET    /admin/outbound_requests/:id(.:format) admin/outbound_requests#show

You will also get a rake task:
    rake requests:clean[age]  # Delete old outbound requests (DEFAULT= 2.months).

#### Methods
If you want to get the request elapse time, you can call (`elapsed_time`):
    outbound_request = OutboundRequest.create(service: :twitter, identifier: 'abletech', action: :dm)
      # do request here
    outbound_request.update_attribute(:response_code, response.code)

    outbound_request.elapsed_time

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
