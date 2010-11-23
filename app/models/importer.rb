class Importer < ActiveRecord::Base

  has_attached_file :csv, :path => ":rails_root/public/:class/:id/:basename.:extension",
                          :url  => "/:class/:id/:basename.:extension"

  validates_attachment_presence :csv

end
