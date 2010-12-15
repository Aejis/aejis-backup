#TODO - make log and alert helpers
module AejisBackup
  module Helpers
    def config_accessor(*names)
      names.each do |name|
        instance_eval %{
          def #{name}(#{name}=nil)
            #{name} ? (@#{name} = #{name}) : @#{name}
          end
          alias :#{name}= :#{name}
        }
      end
    end

    def say(message, color=:null)
      colors = {
        :null   => "0",
        :red    => "31",
        :green  => "32",
        :yellow => "33",
        :purple => "35",
        :cyan   => "36"
      }
      unless defined?(::BACKUP_SILENT)
        puts STDOUT.tty? ? "\e[#{colors[color.to_sym]}m#{message}\e[0m" : message
      end
    end

    def run(cmd, message=false, color=:null)
      say(message, color) if message
      `#{cmd}`
    end
  end
end