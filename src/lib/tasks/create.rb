module ZipitTasks
  module Create
    
    include ZipitUtils::Loader
    acts_as_zipit

    def self.create(app_name, options)
      output, root, conf = options[:output] || ".", options[:root] || "./zipit", options[:conf] || "config.json"

      STDOUT.puts %~Installing new zipit project "#{app_name}" at #{root} with output at #{output}~
      root = create_dir root; output = create_dir output
      conf = create_file path_for(conf,root), get_example_json(app_name)
      
      create_zipit_conf root, :output=>output.path, :conf=>conf.path
      conf.close and root.conf and output.close
    end
    
    private
    
      def self.create_zipit_conf root, options
        internal_conf = create_file(path_for("zipit_conf",root)) do
          options.merge({
            
          }).to_yaml
        end
      end
      
      def self.get_example_json app_name
        {
          :app_name=>app_name,
          :resources=>{},
          :modules=>{}
        }.to_json
      end
    
  end
  
end