module ZipitJS
  module Tasks
    class Install < Task
      
      def install
        modules = ZipitJS::Config.config("modules")
        modules.each do |modvle, repository| # => module, repository
          %x[git init] unless File.directory? ".git"
          %x[git submodule add #{repository} #{@source_path}#{modvle}]
        end
      end
      
    end
  end
end