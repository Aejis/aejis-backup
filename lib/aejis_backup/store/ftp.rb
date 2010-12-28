require "net/ftp"

module AejisBackup
  module Store
    class Ftp < Abstract
      def initialize
        config_accessor :server, :path, :user, :password
      end

      def store!(file)
        say("Copying backup to #{server} starts", :green)
        Net::FTP.open(server) do |ftp|
          ftp.login(user, password) rescue say("Could not login with user '#{user}'", :red) and exit
          ftp.chdir(path)           rescue say("Could not find or access '#{path}'", :red)  and exit
          ftp.putbinaryfile(file)   rescue say("Could not save file to '#{path}'", :red)    and exit
        end
        say("Copying backup to #{server} finished", :green)
      end
    end
  end
end