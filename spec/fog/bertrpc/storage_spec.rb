require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper'))

require 'fog/bertrpc/storage'

describe "fog-bertrpc" do
  let(:storage) do
    storage = Fog::Storage.new({
      :provider   => 'Bertrpc',
      :url        => 'bertrpc://localhost'
    })
  end
  
  let(:service_mock) do
    ServiceMock.new
  end
  
  before :each do
    BERTRPC::Service.stub(:new).and_return(service_mock)
  end
  
  it "creates a directory" do
    directory = storage.directories.create(
      :key => 'mykey'
    )
  end
  
  it "lists directories" do
    storage.directories.first.key.should == 'mykey'
  end
  
  it "gets a directory" do
    x = storage.directories.get('mykey')
    x.should be_kind_of(Fog::Storage::Bertrpc::Directory)
    x.key.should == 'mykey'
  end
  
  it "returns nil for unknown directory keys" do
    x = storage.directories.get('something_strange')
    x.should be_nil
  end
end
