module AejisBackup
  module Adapter
    class Abstract
      # Set config in one line, useful with authomatic #rails method
      def set_config(conf)
        (@login, @pass, @db_name = conf[:user], conf[:password], conf[:database]) or raise ArgumentError
      end

      # Set login for access
      def user(login)
        @login = login
      end
      alias :user= :user

      # Set password for access
      def password(pass)
        @pass = pass
      end
      alias :password= :password

      # Set database name
      def database(db_name)
        @db_name = db_name
      end
      alias :database= :database

      # Get data for backup
      def get!
      end
    end
  end
end