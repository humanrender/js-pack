module ZipitJS
  module Logger
    def self.error exception, label = ""
      output = %~ #{label}
      
      #{exception.class} (#{exception.message}):
        #{exception.backtrace.join("\n        ")}
      ~
      STDOUT.puts output
    end
  end
end