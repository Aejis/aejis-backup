module AejisBackup
  class Configuration
    def initialize(name)
      @name = name
    end

    def adapter(name, &block)
      if name.is_a?(Hash)
        config = name
        name   = config.delete(:adapter)
      else
        raise "#{name.to_s.capitalize} adapter in #{@name} backup not configured" unless block_given?
        config = nil
      end

      required_adapter = case name.to_sym
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
          raise "Adapter #{name.to_s} not known"
      end
      @adapter = required_adapter.new
      config ? @adapter.set_config(config) : @adapter.instance_eval(&block)
    end

    def storage(name, &block)
      raise "#{name.to_s.capitalize} storage in #{@name} backup not configured" unless block_given?
      required_storage = case name.to_sym
        when :cloudfiles
          Storage::CloudFiles
        when :ftp
          Storage::Ftp
        when :local
          Storage::Local
        when :s3, :amazon
          Storage::S3
        when :scp
          Storage::Scp
        when :sftp
          Storage::Sftp
        else
          raise "Storage #{name.to_s} not known"
      end
      @storage = storage.new
      @storage.instance_eval(&block)
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