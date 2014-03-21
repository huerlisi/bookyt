# Backup Model
#
# A backup model is a subclass of an Attachment. It actually is a YAML file
# that contains all the database records.
class Backup < Attachment
  alias tenant object

  # Export Data as YAML
  #
  # This method creates a YAML file out of all the records in the database.
  # This file is normaly attached to a Tenant record.
  #
  # Use this method for backup or migrations.
  def export
    temp = Tempfile.open('export')
    temp.binmode

    old_level = ActiveRecord::Base.logger.level
    ActiveRecord::Base.logger.level = 2 # don't log debug or info
    YamlDb::Helper.dumper.dump(temp)
    ActiveRecord::Base.logger.level = old_level

    temp.close
    title = "Backup %s.yaml" % DateTime.now.to_s(:db)

    self.file = temp
    self.title = title
  end

  # Import Data from a Backup record
  #
  # This method restores a backup from a Backup record
  # This record is normaly attached to a Tenant record.
  #
  # Use this method to restore.
  def import
    self.class.import_file(file.current_path)
  end

  # Import Data from a file
  #
  # This method loads a backup YAML file and creates records in the database.
  # This file is normaly attached to a Tenant record.
  #
  # Use this method for restore or migrations.
  def self.import_file(path)
    yaml_file = File.new(path, "r")

    old_level = ActiveRecord::Base.logger.level
    ActiveRecord::Base.logger.level = 2 # don't log debug or info
    YamlDb::Helper.loader.load(yaml_file, true)
    ActiveRecord::Base.logger.level = old_level
  end
end
