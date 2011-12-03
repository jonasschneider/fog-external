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
  
  describe "#directories" do
    it "#create creates a directory" do
      service_mock.call.directories.should_receive(:create).with('mykey')
      directory = storage.directories.create key: 'mykey'
    end
    
    it "#all lists directories" do
      service_mock.call.directories.should_receive(:list) { [{:key => 'mykey'}] }
      storage.directories.all.first.key.should == 'mykey'
    end
    
    describe "#get" do
      it "gets a directory" do
        service_mock.call.directories.should_receive(:get).with('mykey') { {:key => 'mykey'} }
        x = storage.directories.get('mykey')
        x.should be_kind_of(Fog::Storage::Bertrpc::Directory)
        x.key.should == 'mykey'
      end
      
      it "returns nil for unknown directory keys" do
        service_mock.call.directories.should_receive(:get).with('something_strange') { nil }
        x = storage.directories.get('something_strange')
        x.should be_nil
      end
    end
  end
  
  describe "directory model" do
    let(:dir) { Fog::Storage::Bertrpc::Directory.new connection: storage, key: 'mykey' }
    
    it "#files"
    
    it "#destroy" do
      service_mock.call.directories.should_receive(:destroy).with('mykey')
      dir.destroy
    end
    
    it "#public=" do
      (dir.public = :a).should == :a
    end
    
    it "#public_url" do
      dir.public_url.should be_nil
    end
    
    it "#save" do
      service_mock.call.directories.should_receive(:create).with('mykey')
      dir.save
    end
  end
end
