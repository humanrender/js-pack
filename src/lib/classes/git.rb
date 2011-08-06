module JSPack
  module Utils
    module Git
      module Submodule
        
        def self.remove module_path
          remove_config module_path
          remove_dir module_path
        end
        
        def self.has_submodule? submodule
          %x[ git ls-files --error-unmatch --stage -- "#{submodule}" | grep -E '^160000'] != ""
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
        
      end      
    end
  end
end