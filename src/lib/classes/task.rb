module JSPack
  module Utils; end
  
  module Tasks
    class Task
      include JSPack::Mixins::Resource
      include JSPack::Mixins::Paths
      include JSPack::Utils
      include JSPack::Logger
      include JSPack::UseConfig      
      def initialize
        set_output_path and set_source_path
      end
      
      def switch_dirs dir
        original = FileUtils.pwd
        FileUtils.cd dir
        yield
        FileUtils.cd original
      end
      
    end
  end
end