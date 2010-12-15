module AejisBackup
  module Adapter
    class Archive
      include AejisBackup::Helpers

      def initialize
        config_accessor :path, :format
        compression_level 6
      end

      def compression_level(level=false)
        return @compression_level unless level
        if level.is_a?(Symbol) or level.is_a?(String)
          @compression_level = case level.to_sym
            when :lowest
              1
            when :low
              3
            when :middle
              5
            when :high
              7
            when :highest
              9
          end
        elsif level.is_a? Numeric
          level = level.round
          @compression_level = if level < 1
            1
          elsif level > 9
            9
          end
        end
      end

      def get!(tmpfile)
        dir, target = File.dirname(path), File.basename(path)
        run("tar -C #{dir} -c #{target} | #{archive(tmpfile)}", "Archiving #{path} with #{format}", :green)
      end

      private

        def archive(tmpfile)
          case format
            when :bz2, :bzip, :bzip2
              "bzip2 -z -#{compression_level} > #{tmpfile}.tar.bz2"
            when :gz
              "gzip -#{compression_level} > #{tmpfile}.tar.gz"
            when :xz
              "xz -z -#{compression_level} > #{tmpfile}.tar.xz"
            else
              "bzip2 -z -#{compression_level} > #{tmpfile}.tar.bz2"
          end
        end
    end
  end
end