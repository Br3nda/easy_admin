module EasyAdmin
  class ActiveRecordGenerator < Rails::Generators::Base
    desc "Generates the migration for outbound_requests table"
    source_root File.expand_path('../templates', __FILE__)

    def outbound_request_migration
      copy_file "create_outbound_requests.rb", "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_outbound_requests.rb"
    end
  end
end