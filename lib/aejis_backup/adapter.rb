module AejisBackup
  module Adapter
    autoload :Abstract,   'aejis_backup/adapter/abstract'
    autoload :Archive,    'aejis_backup/adapter/archive'
    autoload :Mongo,      'aejis_backup/adapter/mongo'
    autoload :Mysql,      'aejis_backup/adapter/mysql'
    autoload :Postgresql, 'aejis_backup/adapter/postgresql'
    autoload :Sqlite,     'aejis_backup/adapter/sqlite'
  end
end