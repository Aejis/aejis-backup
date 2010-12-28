require "net/sftp"

module AejisBackup
  module Store
    class Sftp < Abstract
      def initialize
        config_accessor :server, :path, :user, :password
      end

      def store!(file)
        say("Copying backup to #{server} starts", :green)
        Net::SFTP.start(server, user, :password => password) do |sftp|

          sftp.opendir(path) do |response|
            case response.code
              when 0
                # Do nothing
              when 10
                sftp.mkdir!(path) rescue say("Could not access '#{path}'", :red) and exit
              when 3
                say("Could not access '#{path}', permission denied", :red) and exit
              else
                say(response.to_s, :red) and exit
            end
          end

          # TODO - make progressbar or handler here
          sftp.upload!(file, File.join(path, File.basename(file))) rescue
            say("Could not save file to '#{path}'", :red) and exit
        end
        say("Copying backup to #{server} finished", :green)
      end
    end
  end
end