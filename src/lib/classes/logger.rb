module JSPack
  module Logger
    
    def self.included base
      base.extend ClassMethods
      base.acts_as_logger base
    end
    
    def self.error exception, label = ""
      output = %~ #{label}
      
      #{exception.class} (#{exception.message}):
        #{exception.backtrace.join("\n        ")}
      ~
      STDOUT.puts output
    end
    
    def self.log message
      STDOUT.puts message
    end
    
    module ClassMethods
      def acts_as_logger base
        base.class == Class ? include(LoggerMethods) : self.extend(LoggerMethods)
      end
    end
    
    module LoggerMethods
      def log message
        Logger.log message
      end

      def log_error exception, label = ""
        Logger.error exception, label
      end
    end
  end
end