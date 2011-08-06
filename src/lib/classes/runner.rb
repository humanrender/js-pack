module JSPack
  class Runner
    
    include JSPack::RequireRelative
    
    def run_task task, *args
      task = task.to_s
      require_relative "../tasks/#{task}.rb"
      task_class = (task.split(/[^a-z0-9]/i).map{|w| w.capitalize}.join)
      task_class = JSPack::Tasks.const_get(task_class)
      task_class.new.send(task,*args)
    end
    
  end
end