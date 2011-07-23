module ZipitJS::Tasks; end

module ZipitJS
  class Engine
    
    include ZipitJS::Tasks
    
    def initialize
      @loader = Loader.new
      @runner = ZipitJS::Runner.new
    end
    
    def run_task task, *args
      @runner.run_task task, *args
    end
    
  end
end

