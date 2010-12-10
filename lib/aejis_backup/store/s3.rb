require "fog"

module AejisBackup
  module Store
    class S3
      def connection
        @connection ||= Fog::AWS::Storage.new(
          :aws_access_key_id     => access_key_id,
          :aws_secret_access_key => secret_access_key,
          :host                  => host
        )
      end

      def store!(files)
        connection.put_bucket(bucket)
        files.each do |file|
          file_name = File.basename(file)
          file_body = File.open(file)
          connection.put_object(bucket, file_name, file_body)
        end
      end

      def access_key_id(access_key=false)
        access_key ? (@access_key = access_key) : @access_key
      end
      alias :access_key_id= :access_key_id

      def secret_access_key(secret_access_key=false)
        secret_access_key ? (@secret_access_key = secret_access_key) : @secret_access_key
      end
      alias :secret_access_key= :secret_access_key

      def host(host=false)
        host ? (@host = host) : @host
      end
      alias :host= :host

      def bucket(bucket=false)
        bucket ? (@bucket = host) : @bucket
      end
      alias :host= :host

      def use_ssl
        @ssl = true
      end

      def use_ssl?
        @ssl || false
      end
    end
  end
end