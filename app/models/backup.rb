# Backup Model
#
# A backup model is a subclass of an Attachment. The attached file is a zip file
# containing the data and schema. The first actually is a YAML file
# that contains all the database records. It also includes the schema.rb to
# allow restoring backups on newer versions.

require 'zip'

class Backup < Attachment
  alias tenant object

  # Dump data to file
  #
  # We use YAML to dump data to a file.
  def self.dump_data(temp)
    temp.binmode

    old_level = ActiveRecord::Base.logger.level
    ActiveRecord::Base.logger.level = 2 # don't log debug or info
    YamlDb::Helper.dumper.dump(temp)
    ActiveRecord::Base.logger.level = old_level

    temp.close
  end

  # Dump schema to file
  #
  # We persist the schema.rb to provide the YAML loader with the same database
  # structure as on dump.
  def self.dump_schema(temp)
    temp.binmode

    ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, temp)
    temp.close
  end

  # Build ZIP out of schema and data
  #
  # To save some space and include all relevant data in a single file, we use a
  # zip file.
  def self.build_zip(zip, schema, data)
    Zip::File.open(zip, Zip::File::CREATE) do |zipfile|
      zipfile.add('schema.rb', schema.path)
      zipfile.add('data.yml', data.path)
    end
  end

  # Create backup and attach to this record
  #
  # We create a zip containing all backup information and attach it to a
  # Backup models file attribute.
  #
  # Use this method for backup or migrations.
  def self.dump(zip_path = nil)
    dir = Dir.mktmpdir 'bookyt.backup'

    zip = zip_path || Pathname.new(dir).join('backup-v1.zip')

    data = Tempfile.new('data.yml', dir)
    dump_data(data)

    schema = Tempfile.new('schema.rb', dir)
    dump_schema(schema)

    build_zip(zip, schema, data)

    data.unlink
    schema.unlink

    title = "Backup %s" % DateTime.now.to_s(:db)

    # Return a file instance so we can unlink the directory now so the
    # responsibility to cleanup is not on the caller.
    # TODO: test if we can remove the directory before finishing reading
    # a file it contains on Windows.
    zip_file = File.new(zip, 'r')
    FileUtils.rmdir(dir)

    zip_file
  end

  def dump
    self.file = self.class.dump
    self.title = title
  end

  # Extract data from zip
  #
  # Extract schema.rb and data.yml from the zip file.
  def self.extract_zip(zip, schema_path, data_path)
    Zip::File.open(zip) do |zipfile|
      schema = zipfile.glob('schema.rb').first
      schema.extract(schema_path)
      data = zipfile.glob('data.yml').first
      data.extract(data_path)
    end
  end

  # Restore database schema
  #
  # Simply load the passed in schema.rb file.
  def self.restore_schema(path)
    load(path)
  end

  # Import Data from a file
  #
  # This method loads a backup YAML file and creates records in the database.
  def self.restore_data(path)
    yaml_file = File.new(path, "r")

    old_level = ActiveRecord::Base.logger.level
    ActiveRecord::Base.logger.level = 2 # don't log debug or info
    YamlDb::Helper.loader.load(yaml_file, true)
    ActiveRecord::Base.logger.level = old_level
  end

  # Restore Data from a Backup record
  #
  # This method restores a backup from a Backup record
  # This record is normaly attached to a Tenant record.
  #
  # Use this method for restore or migrations.
  def self.restore(path)
    dir = Dir.mktmpdir 'bookyt.backup'
    dirname = Pathname.new(dir)

    extract_zip path, dirname.join('schema.rb'), dirname.join('data.yml')

    restore_schema(dirname.join('schema.rb'))

    restore_data(dirname.join('data.yml'))

    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, nil)
  end

  def restore
    self.class.restore file.current_path
  end
end
