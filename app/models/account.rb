# Account model decoration
#
# We use this file to decorate Account models with attachments.

# Explicit load of Account model from has_accounts gem.
require HasAccounts::Railtie.config.root.join('app', 'models', 'account')

# Reopen class do add decorations
Account.class_eval do
  # Attachments
  # ===========
  has_many :attachments, :as => :reference
  accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['file'].blank? }
end
