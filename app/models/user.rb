class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :person_id

  # Aspects
  include SentientUser

  # Authorization roles
  has_and_belongs_to_many :roles
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  # Associations
  belongs_to :person
  
  # Shortcuts
  def current_company
    person.try(:employers).try(:first)
  end
end
