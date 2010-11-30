module AejisBackup
  module Storage
    autoload :CloudFiles, 'storage/cloud_files'
    autoload :Dropbox,    'storage/dropbox'
    autoload :Ftp,        'storage/ftp'
    autoload :Local,      'storage/local'
    autoload :S3,         'storage/s3'
    autoload :Scp,        'storage/scp'
    autoload :Sftp,       'storage/sftp'
  end
end