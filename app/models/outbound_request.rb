# == Schema Information
#
# Table name: outbound_requests
#
#  id            :integer         not null, primary key
#  service       :string(255)
#  action        :string(255)
#  identifier    :string(255)
#  params        :text
#  response_code :string(255)
#  response_body :text
#  error         :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class OutboundRequest < ActiveRecord::Base
  serialize :params
  serialize :response_body
  serialize :error
  serialize :identifier

  self.per_page = 50

  scope :partial_search, lambda { |column, query|
    where("lower(#{column}) LIKE lower(?)", "%#{query}%")
  }

  def self.search(params)
    identifier = params[:identifier]
    service = params[:service]
    action = params[:request_action]

    requests = self.order('created_at desc')
    requests = requests.partial_search(:identifier, identifier) if identifier.present?
    requests = requests.where(service: service) if service.present?
    requests = requests.where(action: action) if action.present?
    requests = requests.page(params[:page])
  end

  def self.delete_requests_older_than(age)
    self.where('created_at < ?', (Time.now - age)).delete_all
  end

  def elapsed_time
    updated_at - created_at
  end

  def self.rpm(params={})
    period = params[:period] || 60 # period in seconds
    mins_per_period = period / 60.0

    query = where('created_at > ?', Time.current - period.seconds)

    [:service, :action, :response_code].each do |filter|
      if params[filter]
        query = query.where(filter => params[filter])
      end
    end

    query.count / mins_per_period
  end

  def self.response_summary(params={})
    period = params[:period] || 60

    query = where('created_at > ?', Time.current - period.seconds)

    [:service, :action].each do |filter|
      if params[filter]
        query = query.where(filter => params[filter])
      end
    end

    query.group('response_code').count
  end
end
