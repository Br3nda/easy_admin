class CreateOutboundRequests < ActiveRecord::Migration
  def change
    create_table :outbound_requests do |t|
      t.string :service
      t.string :action
      t.string :identifier
      t.text :params
      t.string :response_code
      t.text :response_body
      t.text :error
      t.timestamps
    end

    add_index :outbound_requests, :service
    add_index :outbound_requests, [:service, :action]
    add_index :outbound_requests, [:service, :identifier]
  end
end
