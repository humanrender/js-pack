module JSPack
  module Tasks
    class Create
      
      include JSPack::Mixins::Resource
      include JSPack::Template
      
      def create(app_name, options)
        root, conf = options[:root] || ".", "#{options[:conf]}.json" || "pack.json"
        output = options[:output] || "#{root}/" and source = options[:source] || "#{root}/source/"
        spec = conf.sub ".json", ".spec"
        log %~Creating new js-pack project "#{app_name}" at #{root} with output at #{output}~
        root = create_dir root; output = create_dir output
        spec = create_file path_for(spec,root), {}.to_yaml
        conf = create_file path_for(conf,root), get_example_json(app_name)
        create_jpack_conf root, :output=>output.path, :conf=>conf.path, :source=>source, :spec=>spec
        conf.close and root.conf and output.close
      end
    
      private
    
        def create_jpack_conf root, options
          relativize_paths options, root, :output, :conf, :source, :spec
          internal_conf = create_file(path_for(JP::CONF_FILE,root)) do
            render "js-pack_conf.erb", options
          end
        end
      
        def get_example_json app_name
          render "app_conf.erb", { :app_name=>app_name }
        end
    
    end
  
  end
end