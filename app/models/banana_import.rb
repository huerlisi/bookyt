# based on a Ryan Bates article http://railscasts.com/episodes/219-active-model
class BananaImport  
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :file
  
  validates_presence_of :file

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end
