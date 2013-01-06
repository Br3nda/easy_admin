module EasyAdmin
  class Engine < ::Rails::Engine
    require 'will_paginate'
  end

  class Railtie < ::Rails::Railtie
    rake_tasks do
      namespace :requests do
        desc "Delete old outbound requests (DEFAULT= 2.days)."
        task :clean, [:age] => :environment do |task, params|
          params.with_defaults(age: 2.days)
          outbound_request_count = OutboundRequest.delete_requests_older_than(params[:age])
          puts "Deleted #{outbound_request_count} old Outbound Requests"
        end
      end
    end
  end
end
