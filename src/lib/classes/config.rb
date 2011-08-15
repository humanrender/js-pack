module JSPack
  module Config
    @@loaded = false
    
    def self.load_config force = false
      return if @@loaded && !force
      @@internal = YAML::load(File.open JP::CONF_FILE)
      @@project = @@internal["config"] ? JSON.parse(File.open(JP::ROOT+@@internal["config"]).read) : {}
      @@loaded = true
    end
    
    def self.[] key
      get_config_val @@internal, *key
    end
    
    def self.app_config *keys, &callback
      get_config_val @@internal, *keys, &callback
    end
    
    def self.config *keys, &callback
      get_config_val @@project, *keys, &callback
    end
    
    def self.internal_config
      @@internal
    end
    
    def self.project_config
      @@project
    end
    
    private
      
      def self.get_config_val dictionary, *keys, &callback
        load_config unless @@loaded
        value = recursive_config dictionary, *keys
        if !value && callback
          recursive_config dictionary, *keys, do |dic, key|
            unless callback.nil?
              callback.call dic, key
            else
              nil
            end
          end
        end || value
      end
      
      def self.recursive_config dictionary, *keys, &block
        case keys.length
          when 1
            key = keys[0].to_s
            value = dictionary[key]
            if block_given? && !value
              default_value = block.call dictionary, key
              dictionary[key] = default_value if default_value
            else
              value
            end
          else 
            dictionary_length = keys.length - 1;  depth = 0;
            created_hashes = []
            property = dictionary
            keys.each  do |key|
              key = key.to_s
              if depth == dictionary_length
                default_value = block.nil? ? nil : block.call(property, key)
                if default_value
                  property[key] = default_value 
                else
                  new_properties = created_hashes.shift
                  new_properties[0].delete new_properties[1]
                end
              else
                created_hashes << [property,key]
                property[key] = {}
              end unless property.key? key
              depth = depth + 1
              property = property[key]
            end
            property
        end
      end
    
  end
  module UseConfig    
    
    def self.included base
      base.extend ClassMethods
    end
    
    def get_config *keys
      Config.config *keys
    end
    
    module ClassMethods
      def get_config *keys, &callback
        Config.config *keys, &callback
      end
      def get_app_config *keys
        Config.app_config *keys
      end
      def app_config key
        Config[key]
      end      
    end
    
  end
end