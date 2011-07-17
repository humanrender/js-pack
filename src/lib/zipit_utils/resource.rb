module ZipitUtils
  module Resource
    
    def self.included(base)
      base.extend ClassMethods
    end

      module ClassMethods
    
        def create_dir path
          create_resource Dir, path
        end

        def create_file path, contents = nil
          file = create_resource File, path do
            if block_given?
              yield
            else
              contents
            end
          end
        end
    
        private
    
          def create_resource resource_klass, path
            exists = resource_klass.exists?(path)
            resource =  case resource_klass.to_s
              when "Dir"
                Dir::mkdir(path) unless exists
                Dir.open(path) 
              when "File"
                file = File.open(path,exists ? "a" : "w+")
                if !exists
                  file.write(yield) if block_given?
                end
                file
            end
            STDOUT.puts %~ #{exists ? "exists" : "create"} #{resource.path}~
            resource
          end

    

          def path_for file, directory
             if file.class == File
                return file.path
              else
                file = file
              end
            directory = directory.class == Dir ? directory.path : directory
            %~#{directory}/#{file}~
          end
    
      end
    end
end