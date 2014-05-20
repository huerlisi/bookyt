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
  def dump
    dir = Dir.mktmpdir 'bookyt.backup'

    data = Tempfile.new('data.yml', dir)
    data.binmode

    old_level = ActiveRecord::Base.logger.level
    ActiveRecord::Base.logger.level = 2 # don't log debug or info
    YamlDb::Helper.dumper.dump(data)
    ActiveRecord::Base.logger.level = old_level

    data.close

    schema = Tempfile.new('schema.rb', dir)
    schema.binmode

    ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, schema)
    schema.close

    zip = Pathname.new(dir).join('backup-v1.zip')
    Zip::File.open(zip, Zip::File::CREATE) do |zipfile|
      zipfile.add('schema.rb', schema.path)
      zipfile.add('data.yml', data.path)
    end

    data.unlink
    schema.unlink

    title = "Backup %s" % DateTime.now.to_s(:db)

    zip_file = File.new(zip, 'r')
    # TODO: test if we can remove the directory before finishing reading
    # a file it contains on Windows.
    FileUtils.rmdir(dir)

    self.file = zip_file
    self.title = title
  end

  # Import Data from a Backup record
  #
  # This method restores a backup from a Backup record
  # This record is normaly attached to a Tenant record.
  #
  # Use this method to restore.
  def import
    dir = Dir.mktmpdir 'bookyt.backup'
    dirname = Pathname.new(dir)

    Zip::File.open(file.current_path) do |zipfile|
      schema = zipfile.glob('schema.rb').first
      schema.extract(dirname.join('schema.rb'))
      data = zipfile.glob('data.yml').first
      data.extract(dirname.join('data.yml'))
    end

    load(dirname.join('schema.rb'))
    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, nil)

    self.class.import_file(dirname.join('data.yml'))
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
