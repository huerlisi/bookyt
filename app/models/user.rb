class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # API
  devise :token_authenticatable
  before_save :ensure_authentication_token

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Tenancy
  belongs_to :tenant

  # Authorization roles
  has_and_belongs_to_many :roles, :autosave => true
  scope :by_role, lambda{|role| include(:roles).where(:name => role)}
  attr_accessible :role_texts

  def role?(role)
    !!self.roles.find_by_name(role.to_s)
  end

  def role_texts
    roles.map{|role| role.name}
  end

  def role_texts=(role_names)
    self.roles = Role.where(:name => role_names)
  end

  # Associations
  belongs_to :person
  #validates_presence_of :person
  accepts_nested_attributes_for :person
  attr_accessible :person, :person_id, :person_attributes

  # Shortcuts
  def current_company
    person.try(:employers).try(:first)
  end

  # Locale
  attr_accessible :locale

  # Helpers
  def to_s
    person.try(:to_s) || ""
  end
end
