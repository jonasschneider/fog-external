require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper'))

require 'fog/bertrpc/storage'

describe "fog-bertrpc" do
  it "works" do
    storage = Fog::Storage.new({
      :provider   => 'Bertrpc',
      :url        => 'bertrpc://localhost'
    })
    
    directory = storage.directories.create(
      :key => 'mykey'
    )
    
    storage.directories.first.key.should == 'mykey'
  end
end
