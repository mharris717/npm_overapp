module NpmOverapp
  class << self
    def project_root_dir
      File.expand_path(".")
    end

    def load_files!
      %w(overlay test_server).each do |f|
        load File.dirname(__FILE__) + "/npm_overapp/tasks/#{f}.rb"
      end
    end

    def define_tasks!
      load_files!
    end
  end
end

require 'rake'
NpmOverapp.load_files!