#!/usr/bin/env ruby

require File.expand_path("../lib/classes/loader.rb", __FILE__)
require File.expand_path("../lib/classes/engine.rb", __FILE__)

class JP < Thor
  
  VERSION = "0.0"
  PROJECT_NAME = "JS Pack"
  ROOT = Dir.pwd+"/"
  
  CONF_FILE = ".js-pack"
  
  include JSPack
  
  def initialize a, b, c
    super a, b, c
    @engine = JSPack::Engine.new
  end
  
  no_tasks do

    def load_config
      JSPack::Config.load_config
    end

  end
  
  map "-L" => :list
  
  desc "create APP_NAME", "Creates a new #{PROJECT_NAME} project "  
  method_options :root => :string, :output => :string, :conf => :string, :source => :string     
  def create(app_name)
    @engine.run_task :create, app_name, options
  end
  
  desc "install", "Installs packages from git"  
  method_options :force => :boolean, :v=>:boolean
  def install
    load_config
    @engine.run_task :install, !!options[:v]
  end
  
  desc "list [SEARCH]", "list all of the available apps, limited by SEARCH"
  def list(search="")
    # list everything
  end
  
  desc "uninstall", "Removes JSPack and it's dependencies"  
  method_options :commit => :boolean, :rm_output=>:boolean
  def uninstall
    load_config
    @engine.run_task :uninstall
  end
    
end