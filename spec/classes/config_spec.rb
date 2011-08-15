require 'spec_helper'

describe "Configuration" do
  
  it "should be load config file from JP::CONF_FILE" do
    init_engine
    fake_yaml = {"lorem"=>"ipsum"}
    mock_config fake_yaml, "spec/tmp/config_spec.yml"
    JSPack::Config.internal_config.should == fake_yaml
  end
  
  describe "for project" do
    before :all do
      fake_yaml = {"config"=>"spec/tmp/js-pack-config_spec.json"}
      mock_config fake_yaml, "spec/tmp/config_spec.yml"
    end
    
    it "should correctly mirror the JSON properties of config file" do
      JSPack::Config.config(:hello).should == "world"
    end
    
    it "should correctly return nested configuration properties" do
      JSPack::Config.config(:nested, :property).should == {"deep"=>"nesting"}
      JSPack::Config.config(:nested, :property, :deep).should == "nesting"
    end
    
    it "should return nil if the property doesn't exists in the configuration file" do
      JSPack::Config.config(:unexistent).should == nil
      STDOUT.puts JSPack::Config.project_config
    end
    
    it "should return nil if the property doesn't exists in the configuration file and leavo no trace into the configuration hash" do
      JSPack::Config.config(:unexistent).should == nil
      JSPack::Config.project_config.key?("unexistent").should be false
    end
    
    it "should resort to block callback if the property doesn't exists in the configuration file and save it on configruation hash" do
      callback_text = "callback text"
      JSPack::Config.config(:unexistent) do |config, key|
        callback_text
      end.should == callback_text
      JSPack::Config.project_config["unexistent"].should == callback_text
      JSPack::Config.project_config.delete "unexistent"
    end
  

    it "should return nil if the nested property doesn't exists and leavo no trace in the configuration hash" do
      JSPack::Config.config(:unexistent, :property).should == nil
      JSPack::Config.project_config.key?("unexistent").should be false
      JSPack::Config.config(:nested, :deep_into, :another_property).should == nil
      JSPack::Config.project_config.key?("deep_into").should be false
      JSPack::Config.project_config["nested"].should == {"property"=>{"deep"=>"nesting"}}
    end
    
    it "should resort to block callback if the property doesn't exists in the configuration file and save it on configruation hash" do
      callback_text = "callback text"
      JSPack::Config.config(:nested, :deep_into, :another_property) do |config, key|
        callback_text
      end.should == callback_text
      JSPack::Config.project_config["nested"]["deep_into"]["another_property"].should == callback_text
      JSPack::Config.project_config.delete "nested"
    end
    
  end
  
end