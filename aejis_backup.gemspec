spec = Gem::Specification.new do |s|
  s.name              = "aejis_backup"

  s.author            = "Andrey Savchenko"
  s.email             = "andrey@aejis.eu"
  s.license           = 'BSD'

  s.version           = "0.1.0"
  s.date              = Time.now

  s.homepage          = "http://github.com/Aejis/backup"
  s.summary           = "Swiss knife for unix backups"
  s.description       = "Gem for easy backup your database and files. Supported databases: Postgresql. Supported storages: Amazon S3, local disk"

  s.files             = Dir.glob("{bin,lib,spec}/**/*") + ["README"]

  s.bindir            = 'bin'
  s.executables       = ["backup"]
  s.default_executable= 'backup'

  s.require_path      = "lib"

  s.test_files        = Dir.glob("spec/**/*")

  s.add_development_dependency "rspec", ">= 2.0.0"
  s.add_development_dependency "fog",   ">= 0.3.20"

  s.requirements      = ["GNU or BSD tar"]
end