require "fileutils"
require "rubygems"
require "aejis_backup/helpers"
require "aejis_backup/configuration"

module AejisBackup

  class <<self
    include AejisBackup::Helpers

    def config_path(path=false)
      path ? (@@config_path = path) : @@config_path
    end
    alias :config_path= :config_path

    def config(&block)
      return @@config unless block_given?
      @@config = AejisBackup::Configuration.new
      @@config.instance_eval(&block)
    end

    def load
      require @@config_path
    end

    def run!(*names)
      say("Start backups", :cyan)
      # Do backup for all backup sets if sets not defined
      names = config.backups.keys if names.first.nil?

      names.flatten.each do |name|
        say("Backup '#{name}'", :yellow)

        # Get backup, define file- and dirnames
        backup  = config.backups[name.to_sym]
        dirname = "#{name}-#{Time.now.to_i.to_s}"
        tmpdir  = File.join(backup.tmpdir, dirname)

        # Make temporary directory
        # TODO - Create normal exceptions
        FileUtils.makedirs(tmpdir) or raise "You have no access to #{backup.tmpdir} directory"

        # Get all defined sources
        backup.sources.each do |source_name|
          source = config.sources[source_name]
          source.get!(File.join(tmpdir, source_name))
        end

        # Pack backups to tar archive
        archive = tmpdir + '.tar'
        run("tar -C #{backup.tmpdir} -c -f #{archive} #{dirname}", "Create final archive", :green)

        # Store this archive
        config.storages[backup.target].store!(archive)

        # Remove temp dirs and report
        say("Cleanup", :green)
        FileUtils.rm_rf([archive, tmpdir], :secure => true)
        say("Done!", :yellow)
      end

      say("Finish backups", :cyan)
    end
  end
end