module JSPack
  module Config
    @@loaded = false
    
    def self.load_config
      return if @@loaded
      @@internal = YAML::load(File.open JP::CONF_FILE)
      @@project = JSON.parse(File.open(JP::ROOT+@@internal["config"]).read)
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
    
    private
      
      def self.get_config_val dictionary, *keys, &callback
        load_config unless @@loaded
        value = recursive_config dictionary, *keys
        unless value && block_given?
          dictionary_length = keys.length - 1
          recursive_config dictionary, *keys, do |dic, key, depth|
            if depth == dictionary_length
              dic[key] = callback.call
            else
              dic[key] = {}
            end
          end
        end || value
      end
      
      def self.recursive_config dictionary, *keys, &block
        case keys.length
          when 1
            if block_given?
              yield dictionary[keys[0].to_s], dictionary
            else
              dictionary[keys[0].to_s]
            end
          else 
            if block_given?
              keys.each_with_index do |key, depth|
                yield dictionary, key.to_s, depth
              end
            else
              keys.inject(dictionary) do |property, key| 
                return nil unless property.key? key.to_s
                property[key.to_s]
              end
            end
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