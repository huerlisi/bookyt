class Webhook
  attr_reader :model, :event

  def self.call(model, event)
    new(model, event).call
  end

  def initialize(model, event)
    @model = model
    @event = event
  end

  def call
    return unless webhook_url.present?
    begin
      call_webhook_url
    rescue => error
      Rails.logger.error "Webhook to #{webhook_url} failed: #{error}"
    end
  end

  def call_webhook_url
    connection.post do |request|
      request.url webhook_url
      request.headers['Content-Type'] = 'application/json'
      request.body = { :event => event_name, :id => model.id }.to_json
    end
  end

  def event_name
    "#{model.class.to_s.underscore}.#{event}"
  end

  def connection
    @connection ||= Faraday.new do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def webhook_url
    Tenant.first.webhook
  end
end
