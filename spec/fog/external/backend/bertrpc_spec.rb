require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'spec_helper'))
require 'fog/external/backend/bertrpc'

describe "Fog::External::Backend::Bertrpc" do
  let(:backend) { Fog::External::Backend::Bertrpc.new 'localhost', 8000 }
  
  %w(create_directory list_directories get_directory destroy_directory list_files head_file get_file destroy_file save_file).each do |m|
    it "responds to #{m}" do
      backend.should respond_to(m)
    end
  end
end