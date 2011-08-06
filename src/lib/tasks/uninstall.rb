module JSPack
  module Tasks
    class Uninstall < Task
      def uninstall
        modules = JSPack::Config.config("modules")
        modules.each do |modvle, repository|
          module_path = source modvle
          if (dir_exists = File.directory?(module_path)) || (dir_exists && !Git::Submodule.has_submodule?(module_path))
            STDOUT.puts "removing: #{module_path}"
            Git::Submodule.remove module_path
          else
            STDOUT.puts %~
Error removing: #{modvle}
  - directory: #{module_path}
  - repository: #{repository}
  
  Did you remove it manually? Remember to delete the necessary lines at .gitmodules and .git/config~
          end
        end
      end
      
    end
  end
end