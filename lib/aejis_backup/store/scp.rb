require "net/scp"

module AejisBackup
  module Store
    class Scp < Abstract
      def initialize
        config_accessor :server, :path, :user, :password
      end

      def store!(file)
        say("Copying backup to #{server} starts", :green)

        # Make shure what directory exists
        Net::SSH.start(server, user, :password => password) do |ssh|
          ssh.exec "mkdir -p #{path}"
        end

        Net::SCP.start(server, user, :password => password) do |scp|
          # TODO - make progressbar or handler here
          scp.upload!(file, File.join(path, File.basename(file))) rescue
            say("Could not save file to '#{path}'", :red) and exit
        end
        say("Copying backup to #{server} finished", :green)
      end
    end
  end
end