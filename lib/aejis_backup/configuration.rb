require "aejis_backup/adapter"
require "aejis_backup/store"

module AejisBackup
  class Configuration
    def initialize(&block)
      @sources  = Hash.new
      @storages = Hash.new
      instance_exec(&block)
    end

    attr_reader :sources, :storages

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
          AejisBackup::Adapter::Archive
        when :mongo
          AejisBackup::Adapter::Mongo
        when :mysql
          AejisBackup::Adapter::Mysql
        when :pg, :postgres, :postgresql
          AejisBackup::Adapter::Postgresql
        when :sqlite, :sqlite3
          AejisBackup::Adapter::Sqlite
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
          AejisBackup::Store::CloudFiles
        when :dropbox
          AejisBackup::Store::Dropbox
        when :ftp
          AejisBackup::Store::Ftp
        when :local
          AejisBackup::Store::Local
        when :s3, :amazon
          AejisBackup::Store::S3
        when :scp
          AejisBackup::Store::Scp
        when :sftp
          AejisBackup::Store::Sftp
        else
          raise "Store #{adapter.to_s} not known"
      end
      store = required_store.new
      store.instance_eval(&block)
      @storages[name] = store
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