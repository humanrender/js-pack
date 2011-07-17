#!/usr/bin/env ruby
require "./lib/zipit_utils/loader.rb"

class Zipit < Thor
  VERSION = "0.0"
  PROJECT_NAME = "Zipit"
  
  map "-L" => :list
  
  desc "create APP_NAME", "Creates a new #{PROJECT_NAME} project "  
  method_options :root => :string, :output => :string, :conf => :string      
  def create(app_name)
    require "./lib/tasks/create.rb"
    ZipitTasks::Create::create app_name, options
  end
  
  desc "list [SEARCH]", "list all of the available apps, limited by SEARCH"
  def list(search="")
    # list everything
  end
    
end

Zipit.start