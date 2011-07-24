require "erb"

module ZipitJS
  module Template
    
    TEMPLATE_PATH = File.dirname(caller[0])+"/../templates/"
    
    class TemplateEngine
      def initialize path, binding
        @file = File.new(TEMPLATE_PATH+path)
        @template = ERB.new @file.read, nil, "%"
        @binding = binding
      end
    
      def render
        @template.result(@binding) unless @template.nil?
      end
    
    end
    
    class TemplateBinding
      def initialize bindings
        bindings.each do |key, value|
          eval "@#{key} = value"
        end
      end
      def get_binding
        return binding
      end
    end
    
    def render path, options = {}
      binding = TemplateBinding.new(options).get_binding
      TemplateEngine.new(path, binding).render
      
    end
    
    
    
  end
end