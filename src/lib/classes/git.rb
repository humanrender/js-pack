module JSPack
  module Utils
    module Git
      class Submodule
        
        # ====================
        # = Instance Methods =
        # ====================
        
        attr_reader :path, :source, :module
        
        def initialize modwle, data, source_path
          @module = modwle
          @source = data.class == String ? data : data["source"]
          @path = "#{source_path}#{modwle}"
        end
        
        def configured?; self.class.has_submodule?(@path); end
        def exists?; File.directory? @path; end
        
        def install verbose = false
          install! do |status|
            JSPack::Logger.log "#{status}: #{to_s}"
          end
        end
        
        private
        
        def install!
          Submodule.execute (if configured?
            status, command = exists? ? [:exists, ""] : [:updating, "update --init #{@path}"]
            yield status if block_given?
            command
          else
            yield :adding if block_given?
            "add #{@source} #{@path}"
          end)
        end
        
        public
        
        def to_s
          "#{@path}: #{@source}"
        end       
        
        # =================
        # = Class Methods =
        # =================
        
        def self.remove module_path
          remove_config module_path
          remove_dir module_path
        end
        
        def self.has_submodule? submodule
          system %~ git ls-files --error-unmatch --stage -- "#{submodule}" 2>/dev/null | grep -E '^160000' 2>/dev/null~
        end
        
        def self.url module_path
           %x[git config --get submodule."#{module_path}".url]
        end
        
        def self.remove_config module_path
          [%x[git config -f .gitmodules --remove-section submodule."#{module_path}" 2>/dev/null], %x[git config --remove-section submodule."#{module_path}" 2>/dev/null]]
        end
        
        def self.remove_dir module_path
          %x[git rm --cached "#{module_path}"]
          %x[rm -rf "#{module_path}"]
        end
        
        def self.execute command, verbose = false
          %x[git submodule #{command}#{verbose ? "" : " 2>/dev/null"}] unless command.nil? || command.empty?
        end
        
      end      
      
    end
  end
end