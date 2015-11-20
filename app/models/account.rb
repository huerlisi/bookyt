# Account model decoration
#
# We use this file to decorate Account models with attachments.

# Explicit load of Account model from has_accounts gem.
require HasAccounts::Railtie.config.root.join('app', 'models', 'account')

class Account::AmbiguousTag < StandardError;
  def initialize(tag, count)
    @tag = tag
    @count = count
  end

  def to_s
    "Given tag '#{@tag}' is ambiguous, found #{@count} records"
  end
end

# Reopen class do add decorations
Account.class_eval do
  # Attachments
  # ===========
  has_many :attachments, :as => :reference
  accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['file'].blank? }

  def self.find_by_tag(tag)
    accounts = tagged_with(tag)
    count = accounts.count
    raise Account::AmbiguousTag.new(tag, count) if count > 1
    accounts.first
  end
end
