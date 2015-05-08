Upgrade from Bookyt 1.5 to 2.0
==============================

Bookyt 2.0 uses a different database system and supports multi tenancy.
This makes some manual steps necessary. Follow these instruction to enjoy all
the new features of Bookyt 2.0.

If you do not yet run the latest Bookyt 1.x release, please first
upgrade to release 1.5. It is available on github in the stable-1-5 branch.

Backup Data
-----------

    bundle exec rails runner 'Backup.dump("upgrade-to-2.0.zip")'

Create PostgreSQL database
--------------------------

This is how it’s done on Debian/Ubuntu. Please submit a patch if you’ve
figured out the steps on another system.

    sudo apt-get install postgresql

    sed 's/\*mysql/*postgres/' -i 'config/database.yml'

Lookup current username, password and database from config/database.yml
and use them in the following commands.

    sudo -u postgres -i
    createuser $USER_NAME --no-createdb --no-createrole --no-superuser --pwprompt
    createdb --owner $USER_NAME $DATABASE_NAME

On a development system, you probably also want to do the steps for
both the development and test databases.

Restore Data
------------

Now import the data again.

    bundle exec rails runner 'Backup.restore "upgrade-to-2.0.zip"'
