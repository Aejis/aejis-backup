module AejisBackup
  module Adapter
    class Postgresql < Abstract

      def get!(tmpfile)
        ENV['PGPASSWORD'] = password
        run("pg_dump -U #{user} --file=#{tmpfile}.sql #{arguments} #{database}", "Dump database #{database}", :green)
        ENV['PGPASSWORD'] = nil
      end

      private

        def arguments
          args = []
          args << "--format=t"
          # TODO - compression level
          args.join(' ')
        end
    end
  end
end