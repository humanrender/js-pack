require "thor"
require "ruby-debug"
require "yaml"
require "json"

module ZipitUtils
  module Loader
    
    def self.included(base)
      # base.class_eval { @name = "foobar" }
      base.extend ClassMethods
    end

      module ClassMethods

        def acts_as_zipit
          require_classes
          include_classes
        end
        
        private
          def require_classes
            require "./lib/zipit_utils/resource.rb"
          end
          
          def include_classes
            include Resource
          end
      end
  end
end