module JSPack
  module Mixins
    module Resource
      
      def create_dir path
        create_resource :dir, path
      end
      
      def create_file path, contents = nil
        file = create_resource :file, path do
          if block_given?
            yield
          else
            contents
          end
        end
      end
      
      def relative_path destiny,  target
        destiny = Pathname.new destiny
        Pathname.new(target).relative_path_from(destiny).to_s
      end
      
      def relativize_paths obj, root, *relativizables
        case obj
          when Array
            obj.map do |path|
              relative_path root, path
            end
          else
            obj.each do |key,value|
              obj[key] = relative_path root, value
            end
        end
      end
      
      private
      
      def create_resource resource_klass, path
        exists = false
        resource =  case resource_klass
          when :dir
            exists = File.directory?(path)
            FileUtils::mkdir_p(path) unless exists
            Dir.open(path) 
          when :file
            begin
              exists = File.exists?(path)
              file = File.open(path,exists ? "a" : "w+")
              if !exists
                file.write(yield) if block_given?
              end
              file
            rescue Exception => e
              file.close
              File.delete path
              JSPack::Logger.error e, "error: #{path}"
              return nil
            end
        end
        STDOUT.puts %~ #{exists ? "exists" : "create"} #{resource.path}~
        resource
      end
      
      
      public
      
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