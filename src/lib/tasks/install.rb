module JSPack
  module Tasks
    class Install < Task
      
      def install verbose = false
        %x[git init] unless File.directory? ".git"
        log %~Installing pack contents for #{get_config :app_name}~
        mapper = JSPack::ResourceMapper.new @source_path
        packages = mapper.get_packages do |package|
          package.submodule.install verbose
        end
        JSPack::Compiler.compile packages
      end
    end
  end
end