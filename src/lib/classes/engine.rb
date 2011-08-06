module JSPack::Tasks; end

module JSPack
  class Engine
    
    include JSPack::Tasks
    
    def initialize
      @loader = Loader.new
      @runner = JSPack::Runner.new
    end
    
    def run_task task, *args
      @runner.run_task task, *args
    end
    
  end
end

