module AejisBackup
  class Backup
    def initialize
      @tmpdir = '/tmp'
    end

    def sources(*names)
      names.length == 0 ? @sources : (@sources = names)
    end
    alias :source :sources

    def target(name=false)
      name ? (@target = name) : @target
    end

    def tmpdir(path=false)
      path ? (@tmpdir = path) : @tmpdir
    end
  end
end