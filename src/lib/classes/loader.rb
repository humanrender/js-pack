require "rubygems"
require "thor"
require "yaml"
require "json"
require "ruby-debug"
require 'pathname'

module ZipitJS
  
  class Loader 
    
    def initialize
      require_relative "../mixins/resource.rb"
      require_relative "logger.rb"
      require_relative "template.rb"
      require_relative "runner.rb"
    end
    
  end
  
  module RequireRelative
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end