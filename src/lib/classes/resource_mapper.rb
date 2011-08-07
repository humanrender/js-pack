module JSPack
  class ResourceMapper
    
    include JSPack::UseConfig
    include JSPack::Utils
    
    def initialize source_path
      @source_path = source_path
    end
    
    def get_submodules
      packages = get_config :packages
      packages.map do |modwle, data| # => module, repository
        submodule = Git::Submodule.new modwle, data, @source_path
        block_given? ? yield(submodule, data) : submodule
      end
    end
    
    def get_packages &block
      get_submodules do |submodule, data|
        package = JSPack::Package.new submodule, data
        block.call(package) unless block_given?
        package
      end
    end
    
  end
end