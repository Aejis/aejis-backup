require "aejis_backup/adapter"
require "aejis_backup/store"
require "aejis_backup/backup"

module AejisBackup
  class Configuration
    def initialize
      @sources  = Hash.new
      @storages = Hash.new
      @backups  = Hash.new
    end

    attr_reader :sources, :storages, :backups

    def source(name, adapter, &block)
      if adapter.is_a?(Hash)
        config  = adapter
        adapter = config.delete(:adapter)
      else
        raise "#{name.to_s.capitalize} source not configured" unless block_given?
        config = nil
      end

      required_adapter = case adapter.to_sym
        when :archive
          Adapter::Archive
        when :mongo
          Adapter::Mongo
        when :mysql
          Adapter::Mysql
        when :pg, :postgres, :postgresql
          Adapter::Postgresql
        when :sqlite, :sqlite3
          Adapter::Sqlite
        else
          raise "Adapter #{adapter.to_s} not known"
      end
      adapter = required_adapter.new
      config ? adapter.set_config(config) : adapter.instance_eval(&block)
      @sources[name] = adapter
    end

    def storage(name, store, &block)
      raise "#{name.to_s.capitalize} storage not configured" unless block_given?
      required_store = case store.to_sym
        when :cloudfiles
          Store::CloudFiles
        when :dropbox
          Store::Dropbox
        when :ftp
          Store::Ftp
        when :local
          Store::Local
        when :s3, :amazon
          Store::S3
        when :scp
          Store::Scp
        when :sftp
          Store::Sftp
        else
          raise "Store #{adapter.to_s} not known"
      end
      store = required_store.new
      store.instance_eval(&block)
      @storages[name] = store
    end

    def backup(name, &block)
      backup = Backup.new()
      backup.instance_eval(&block)
      @backups[name] = backup
    end

    def rails(environment=:production)
      raise "You are not inside rails or use rails 2.X" unless defined?(Rails)
      rails_config =  ::Rails.configuration.database_configuration[environment.to_s]
      {
        :adapter   => rails_config["adapter"],
        :user      => rails_config["username"],
        :password  => rails_config["password"],
        :database  => rails_config["database"]
      }
    end
  end
end