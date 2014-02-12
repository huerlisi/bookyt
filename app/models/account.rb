require HasAccounts::Railtie.config.root.join('app', 'models', 'account')

Account.class_eval do
  # Attachments
  # ===========
  has_many :attachments, :as => :object
  accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['file'].blank? }
end
