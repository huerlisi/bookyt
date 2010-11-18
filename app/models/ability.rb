# Defines abilities
#
# This class defines the abilities available to User Roles.
# Will be used by CanCan.
class Ability
  # Aspects
  include CanCan::Ability
 
  # Available roles
  def self.roles
    ['admin', 'accountant']
  end
  
  # Prepare roles to show in select inputs etc.
  def self.roles_for_collection
    self.roles.map{|role| [I18n.translate(role, :scope => 'cancan.roles'), role]}
  end
  
  # Main role/ability definitions.
  def initialize(user)
    user ||= User.new # guest user
 
    alias_action :index, :to => :list
    
    if user.role? :admin
      can :manage, :all
    elsif user.role? :accountant
      can :manage, [Account, Balance, BookingTemplate, Customer, Employee, Invoice, Product, AccountType, Booking, Company, Day, Employment, Person, Profit]
      can [:list, :read, :edit], [Tenant], :users => {:id => user.id}
      can [:read, :edit], User, :id => user.id
    end
  end
end
