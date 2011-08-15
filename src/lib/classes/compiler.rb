module JSPack
  module Compiler
    
    include JSPack::UseConfig
    include JSPack::Logger
    self.extend JSPack::Mixins::Resource
    
    def self.compile packages
      compiled_output = ""
      packages.each do |package|
        files = package.files and path = package.path
        compiled_output << compile_files(path,files[:compile])
      end
      output compiled_output
      output compiled_output, true
      
    end
    
    private
    
    def self.compile_files path, files
      return "" if files.nil?
      files.inject "" do |sum, file|
        output = File.read file
        sum + output
      end
    end
    
    def self.output_path min = false
      %~#{Config["output"]}/#{get_config "app_name"}#{min ? ".min" : ""}.js~
    end
    
    def self.output content, min = false
      path = output_path min
      log %~#{File.exists?(path) ? "updating" : "creating"}: #{path}~
      content = YUI::JavaScriptCompressor.new(:munge=>should_munge?).compress(content) if min
      file = File.open(path,"w+")
      file.write content
      file.close
    end
    
    def self.should_munge? 
      get_config "options", "minify" do
        true
      end
    end
        
  end
end