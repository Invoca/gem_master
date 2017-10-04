module GemMaster
  module GemfileMixin
    def gem_master_filename=(filename)
      @gem_master_filename = filename
    end

    def mgem(gem_name, options = nil)
      (gem_args = _gems[gem_name]) or raise "Gem #{gem_name} not found in master"

      if options
        merged_options =
            if gem_args.last.is_a?(Hash)
              gem_args.pop
            else
              {}
            end.merge(options)
        gem_args << merged_options
      end

      gem gem_name, *gem_args
    end

    def _gems
      @gem_master_filename or raise "You must set 'self.gem_master_filename =' first"
      @_gems ||= GemMaster::MasterFile.new(@gem_master_filename)
    end
  end
end

include GemMaster::GemfileMixin
