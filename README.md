# EasyAdmin

A Rails engine containing common admin maintenance screens.
Currently contains Delayed::Job maintenance screens.

## Installation

Add this line to your application's Gemfile:

    gem 'easy_admin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_admin

## Usage

All you need is a Admin::BaseController (which the EasyAdmin controllers will extend). Define any authentication, layout and before_filter logic in here.

### JobsController
To manage Delayed::Jobs, you need to define a method in your Admin::BaseController called authorize_jobs which will control access to the JobsController.

    class Admin::BaseController < ApplicationController
      layout 'admin'      

      private
      
      def authorize_jobs
        @current_user.admin?
      end
    end

You will get the following routes:

    retry_admin_job POST   /admin/jobs/:id/retry(.:format)          admin/jobs#retry
         admin_jobs GET    /admin/jobs(.:format)                    admin/jobs#index
          admin_job GET    /admin/jobs/:id(.:format)                admin/jobs#show
                    DELETE /admin/jobs/:id(.:format)                admin/jobs#destroy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
