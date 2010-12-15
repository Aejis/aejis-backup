require "fog"

module AejisBackup
  module Store
    class S3 < Abstract
      def initialize
        config_accessor :access_key_id, :secret_access_key, :host, :region, :bucket
      end

      def connection
        connection_config = {
          :aws_access_key_id     => access_key_id,
          :aws_secret_access_key => secret_access_key,
          :host                  => host
        }
        connection_config[:scheme] = use_ssl? ? 'https' : 'http'
        @connection ||= Fog::AWS::Storage.new(connection_config)
      end

      def store!(file)
        say("Upload backup to Amazon storage", :green)
        connection.put_bucket(bucket)
        file_name = File.basename(file)
        file_body = File.open(file)
        connection.put_object(bucket, file_name, file_body)
      end

      def use_ssl
        @ssl = true
      end

      def use_ssl?
        @ssl || false
      end
    end
  end
end