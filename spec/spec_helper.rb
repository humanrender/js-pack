require File.dirname(__FILE__) + '/../src/jp.rb'

module JSPackSpecHelper
  
  FAKE_YAML_PATH = "spec/tmp/.js-pack"
  
  FAKE_YAML_CONFIG = {
    "output"=>"spec/tmp/javacripts",
    "config"=>"spec/tmp/js-pack.json",
    "source"=>"spec/tmp/javacripts/source",
    "spec"  =>"spec/tmp/js-pack.spec"
  }
  
  FileUtils.rm_rf "tmp" if File.directory? "tmp"
  FileUtils.mkdir_p "tmp"
  
  def init_engine
    @engine = JSPack::Engine.new
  end
  
  def mock_config yaml = nil
    yaml ||= FAKE_YAML_CONFIG
    File.delete FAKE_YAML_PATH if File.file? FAKE_YAML_PATH
    File.open FAKE_YAML_PATH, "w+" do |file|
      file.write yaml.to_yaml
    end
    FileUtils.cp yaml["config"].gsub(/^spec\/tmp\/(.+\.json)$/,"spec/files/\\1") , yaml["config"]
    JP.const_set "CONF_FILE", FAKE_YAML_PATH
    JSPack::Config.load_config
  end
  
end

RSpec.configure do |config|
  config.include JSPackSpecHelper
end