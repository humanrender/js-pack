module ZipitJS
  module Tasks
    class Create
      
      include ZipitJS::Mixins::Resource
      include ZipitJS::Template
      
      def create(app_name, options)
        output, root, conf = options[:output] || ".", options[:root] || "./zipit", options[:conf] || "config.json"

        STDOUT.puts %~Installing new zipit project "#{app_name}" at #{root} with output at #{output}~
        root = create_dir root; output = create_dir output
        conf = create_file path_for(conf,root), get_example_json(app_name)
      
        create_zipit_conf root, :output=>output.path, :conf=>conf.path
        conf.close and root.conf and output.close
      end
    
      private
    
        def create_zipit_conf root, options
          relativize_paths options, root, :output, :conf
          internal_conf = create_file(path_for("zipit_conf",root)) do
            render "zipit_conf.erb", options
          end
        end
      
        def get_example_json app_name
          render "app_conf.erb", {
            :app_name=>app_name,
            :resources=>{},
            :modules=>{}
          }
        end
    
    end
  
  end
end