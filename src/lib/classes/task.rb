module ZipitJS
  module Utils; end
  
  module Tasks
    class Task
      include ZipitJS::Mixins::Resource
      include ZipitJS::Mixins::Paths
      include ZipitJS::Utils
      
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