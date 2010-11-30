module AejisBackup
  module Adapter
    autoload :Abstract,   'adapters/abstract'
    autoload :Archive,    'adapters/archive'
    autoload :Mongo,      'adapters/mongo'
    autoload :Mysql,      'adapters/mysql'
    autoload :Postgresql, 'adapters/postgresql'
    autoload :Sqlite,     'adapters/sqlite'
  end
end