module ZipitJS
  module Mixins
    module Paths
      
      def set_paths
        set_output_path and set_output_path
      end
      
      def set_output_path
        @output_path ||= "#{ZipitJS::Config["output"]}/"
      end

      def set_source_path
        @source_path ||= "#{ZipitJS::Config["source"]}/"
      end
      
      def source modvle
        "#{@source_path}#{modvle}"
      end
    end
  end
end