module JSPack
  class Package
    
    include JSPack::Mixins::Resource
    include JSPack::UseConfig
    include JSPack::Logger
    
    attr_reader :submodule, :files
    
    def initialize submodule, data
      @submodule = submodule
      @files = if data.class == String
        {:include=>["*"],:compile=>[]}
      else
        {:include=>get_files(data,"include"), :compile=>get_files(data,"compile")}
      end
    end
    
    def path; @submodule.path; end
    
    def get_files data, group
      return [] if data[group].nil?
      $path = path
      data[group].map do |file|
        path_for(file,$path)
      end
    end
    
  end
end