module JSPack
  module Config
    @@loaded = false
    
    def self.load_config load_project = true
      @@internal = YAML::load(File.open JP::CONF_FILE)
      @@project = JSON.parse(File.open(JP::ROOT+@@internal["config"]).read)
      @@loaded = true
    end
    
    def self.[] key
      load_config unless @@loaded
      @@internal[key.to_s]
    end
    
    def self.config key
      load_config unless @@loaded
      @@project[key.to_s]
    end
    
  end
end