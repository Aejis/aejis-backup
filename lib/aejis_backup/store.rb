module AejisBackup
  module Store
    autoload :CloudFiles, 'aejis_backup/store/cloud_files'
    autoload :Dropbox,    'aejis_backup/store/dropbox'
    autoload :Ftp,        'aejis_backup/store/ftp'
    autoload :Local,      'aejis_backup/store/local'
    autoload :S3,         'aejis_backup/store/s3'
    autoload :Scp,        'aejis_backup/store/scp'
    autoload :Sftp,       'aejis_backup/store/sftp'
  end
end