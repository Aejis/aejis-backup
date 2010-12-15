module AejisBackup
  module Store
    class Local < Abstract
      def initialize
        config_accessor :path
      end

      def store!(file)
        FileUtils.makedirs(path) unless File.exists?(path)
        run("cp #{file} #{path}", "Copying backup to #{path}", :green)
      end
    end
  end
end