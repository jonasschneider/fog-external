require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper'))

require 'fog/external/storage'

describe "fog-external" do
  let(:storage) do
    storage = Fog::Storage.new({
      :provider   => 'External',
      :delegate   => service_mock
    })
  end
  
  let(:service_mock) do
    ServiceMock.new
  end
  
  describe "#directories" do
    it "#create creates a directory" do
      service_mock.should_receive(:create_directory).with('mykey')
      directory = storage.directories.create key: 'mykey'
    end
    
    it "#all lists directories" do
      service_mock.should_receive(:list_directories) { [{:key => 'mykey'}] }
      storage.directories.all.first.key.should == 'mykey'
    end
    
    describe "#get" do
      it "gets a directory" do
        service_mock.should_receive(:get_directory).with('mykey') { {:key => 'mykey'} }
        x = storage.directories.get('mykey')
        x.should be_kind_of(Fog::Storage::External::Directory)
        x.key.should == 'mykey'
      end
      
      it "returns nil for unknown directory keys" do
        service_mock.should_receive(:get_directory).with('something_strange') { nil }
        x = storage.directories.get('something_strange')
        x.should be_nil
      end
    end
  end
  
  describe "::Directory" do
    let(:dir) { Fog::Storage::External::Directory.new connection: storage, key: 'mykey' }
    
    it "#files" do
      dir.files.should be_kind_of(Fog::Storage::External::Files)
      dir.files.directory.should == dir
      dir.files.connection.should == storage
    end
    
    it "#destroy" do
      service_mock.should_receive(:destroy_directory).with('mykey')
      dir.destroy
    end
    
    it "#public=" do
      (dir.public = :a).should == :a
    end
    
    it "#public_url" do
      dir.public_url.should be_nil
    end
    
    it "#save" do
      service_mock.should_receive(:create_directory).with('mykey')
      dir.save
    end
  end
  
  describe "::Files" do
    let(:dir) { Fog::Storage::External::Directory.new connection: storage, key: 'mykey' }
    let(:files) { dir.files }
    
    it "#all" do
      service_mock.should_receive(:list_files).with("mykey") { [{:key => 'mykey/a'}] }
      res = files.all
      res.first.key.should == 'mykey/a'
    end
    
    it "#get" do
      data = {:key => 'mykey/a', :content_length => 5, :last_modified => Time.now, :body => 'asdf' }
      service_mock.should_receive(:get_file).with("mykey/a") { data }
      res = files.get('a')
      
      res.key.should == 'mykey/a'
      res.content_length.should == 5
      res.body.should == 'asdf'
    end
    
    it "#head" do
      service_mock.should_receive(:list_files).twice.with("mykey") { [{:key => 'mykey/a'}] }
      
      res = files.head('a')
      
      res.key.should == 'mykey/a'
      res.content_length.should be_nil
      
      files.head('b').should be_nil
    end
    
    it "#new" do
      files.new(:key => 'hai').directory.should == dir
      files.new(:key => 'hai').key.should == 'hai'
    end
  end
  
  describe "::Files" do
    let(:dir) { Fog::Storage::External::Directory.new connection: storage, key: 'mykey' }
    let(:file) { Fog::Storage::External::File.new connection: storage, last_modified: Time.now, key: 'a', directory: dir }
    
    it "#body when the body is not set" do
      data = {:key => 'mykey/a', :content_length => 5, :last_modified => Time.now, :body => 'asdf' }
      service_mock.should_receive(:get_file).with("mykey/a") { data }
      file.body.should == 'asdf'
    end
      
    it "#body when the body is set" do
      file = Fog::Storage::External::File.new connection: storage, key: 'a', directory: dir, body: 'b'
      file.body.should == 'b'
    end
    
    it "#body= sets the body" do
      file.body = 'new'
      file.body.should == 'new'
    end
    
    it "#directory" do
      file.directory.should == dir
    end
    
    it "#content_type" do
      file.key = 'a.txt'
      file.content_type.should == 'text/plain'
    end
    
    it "#destroy" do
      service_mock.should_receive(:destroy_file).with("mykey/a")
      file.destroy
    end
    
    it "#public=" do
      (file.public = :a).should == :a
    end
    
    it "#public_url" do
      file.public_url.should be_nil
    end
    
    it "#save" do
      service_mock.should_receive(:save_file).with("mykey/a", "test")
      file.body = "test"
      file.save
    end
  end
end
