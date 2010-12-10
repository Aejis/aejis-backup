module AejisBackup
  module Adapter
    class Postgresql < Abstract

      def get!
        ENV['PGPASSWORD'] = password
        run "pg_dump -U #{user} #{arguments} #{database}"
        ENV['PGPASSWORD'] = nil
      end

      private

        def arguments
          args = []
          args << "--file=#{backup_name}.sql"
          args << "--format=t" # Compress dump
          args << "--compress=8" # TODO - compression level
          args.join(' ')
        end
    end
  end
end