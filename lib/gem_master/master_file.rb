module GemMaster
  class MasterFile
    attr_reader :gems

    def initialize(master_path)
      @master_path = master_path

      master_gem_file = File.read(master_path)

      @gems = parse(master_gem_file)

      def [](gem_name)
        @gems[gem_name]
      end
    end

    def parse(master_gem_file)
      dsl = Dsl.new
      dsl.instance_eval(master_gem_file)
      dsl.gems
    end
  end


  class Dsl
    attr_reader :gems

    def initialize
      @gems = {}
    end

    def gem(gem_name, *args)
      @gems[gem_name] and raise "Duplicate gem #{gem_name} found!"
      @gems[gem_name] = args
    end
  end
end

