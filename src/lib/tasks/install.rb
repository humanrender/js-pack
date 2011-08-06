module JSPack
  module Tasks
    class Install < Task
      
      def install
        modules = JSPack::Config.config("modules")
        %x[git init] unless File.directory? ".git"
        modules.each do |modvle, repository| # => module, repository
          source_path = "#{@source_path}#{modvle}"
          command = Git::Submodule.has_submodule?(source_path) ? "update --init #{source_path}" : "add #{repository} #{source_path}"
          %x[git submodule #{command}] 
        end
        
      end
      
    end
  end
end