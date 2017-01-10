class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise Settings.devise_backend.to_sym, :recoverable, :rememberable, :trackable, :omniauthable
  devise :validatable unless Settings.devise_backend == 'cas_authenticatable'

  # API
  before_save :ensure_authentication_token

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Tenancy
  belongs_to :tenant

  # Authorization roles
  has_and_belongs_to_many :roles, :autosave => true
  scope :by_role, lambda{|role| include(:roles).where(:name => role)}
  attr_accessible :role_texts

  def cas_extra_attributes=(extra_attributes)
    return unless defined?(CASExtraAttributesMapper)
    CASExtraAttributesMapper.call(extra_attributes, self)
  end

  def role?(role)
    !!self.roles.find_by_name(role.to_s)
  end

  def role_texts
    roles.pluck(:name)
  end

  def role_texts=(role_names)
    self.roles = Role.where(:name => role_names)
  end

  # Associations
  belongs_to :person
  #validates_presence_of :person
  accepts_nested_attributes_for :person
  attr_accessible :person, :person_id, :person_attributes

  def person
    super || build_person
  end

  # Locale
  attr_accessible :locale

  # Helpers
  def to_s
    person.try(:to_s) || ""
  end

  # https://gist.github.com/josevalim/fb706b1e933ef01e4fb6#file-1_unsafe_token_authenticatable-rb-L20
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
