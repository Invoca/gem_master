module GemMaster
  module GemfileMixin
    def gem_master_filename=(filename)
      @gem_master_filename = filename
    end

    def mgem(gem_name)
      (gem_args = _gems[gem_name]) or raise "Gem #{gem_name} not found in master"

      gem gem_name, *gem_args
    end

    def _gems
      @gem_master_filename or raise "You must set 'self.gem_master_filename =' first"
      @_gems ||= GemMaster::MasterFile.new(@gem_master_filename)
    end
  end
end

include GemMaster::GemfileMixin
