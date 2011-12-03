require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper'))

require 'fog/bertrpc/storage'

describe "fog-bertrpc" do
  let(:storage) do
    storage = Fog::Storage.new({
      :provider   => 'Bertrpc',
      :url        => 'bertrpc://localhost'
    })
  end
  
  before :each do
    BERTRPC::Service.stub(:new).and_return(stub)
  end
  
  it "creates a directory" do
    storage.service.stub_chain(:call, :directories, :create).and_return(true)
    
    directory = storage.directories.create(
      :key => 'mykey'
    )
  end
  
  it "lists directories" do
    storage.service.stub_chain(:call, :directories, :list).and_return([:key => 'mykey'])
    
    storage.directories.first.key.should == 'mykey'
  end
end
