module AejisBackup
  module Adapter
    class Mysql < Abstract

      def get!(tmpfile)
        run("pg_dump -u #{user} --password='#{password}' #{database} | gzip -f --best > #{tmpfile}", "Dump database #{database}", :green)
      end
    end
  end
end