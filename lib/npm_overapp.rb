require 'mharris_ext'
require 'rake'

module NpmOverapp
  class << self
    attr_accessor :server_base_overlay, :app_name
    fattr(:server_port) { 5901 }

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

def overapp
  locals = ["/code/orig/overapp/bin/overapp"]
  locals.find { |x| FileTest.exist?(x) } || "overapp"
end

NpmOverapp.load_files!