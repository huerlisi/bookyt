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
    alias_action :current, :to => :show

    # Load the abilities for all roles.
    user.roles.each do |role|
      self.send(role.name, user)
    end
  end
  
  # Admin abilities
  def admin(user)
    can :manage, :all
  end
  
  # Accountant abilities
  def accountant(user)
    can :manage, [Account, BookingTemplate, Customer, Employee, Invoice, Product, AccountType, Booking, Company, Day, Employment, Person, Profit]
    can [:show, :list], [Tenant], :users => {:id => user.id}
    can [:show, :update], User, :id => user.id
  end
end
