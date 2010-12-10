module AejisBackup
  module Adapter
    class Abstract

      # Set config in one line, useful with authomatic #rails method
      def set_config(conf)
        (@user, @password, @database = conf[:user], conf[:password], conf[:database]) or raise ArgumentError
      end

#      config_setter :user, :password, :database

      # Set login for access
      def user(user=nil)
        user ? (@user = user) : @user
      end
      alias :user= :user
      
      # Set password for access
      def password(password=nil)
        password ? (@password = password) : @password
      end
      alias :password= :password
      
      # Set database name
      def database(database=nil)
        database ? (@database = database) : @database
      end
      alias :database= :database

      def backup_name
        Time.now.to_i # TODO - add name
      end

      # Get data for backup
      def get!
      end
    end
  end
end