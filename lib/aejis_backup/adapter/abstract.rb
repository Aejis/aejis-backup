module AejisBackup
  module Adapter
    class Abstract
      include AejisBackup::Helpers

      def initialize
        config_accessor :user, :password, :database
      end

      # Set config in one line, useful with authomatic #rails method
      def set_config(conf)
        (@user, @password, @database = conf[:user], conf[:password], conf[:database]) or raise ArgumentError
      end

      # Get data for backup
      def get!(tmpfile)
      end
    end
  end
end