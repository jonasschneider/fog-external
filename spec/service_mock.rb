class ServiceMock
  def create_directory(key)
    true
  end
  
  def list_directories
    [{:key => 'mykey'}]
  end
  
  def get_directory(key)
    {:key => 'mykey'} || nil
  end
  
  def destroy_directory(key)
    true
  end
  
  
  def list_files(dir_key)
    [{:key => 'mykey/a', :content_length => 5, :last_modified => Time.now}]
  end
  
  def head_file(key)
    {:key => 'mykey/a', :content_length => 5, :last_modified => Time.now} || nil
  end
  
  def get_file(key)
    {:key => 'mykey/a', :content_length => 5, :last_modified => Time.now, :body => 'asdf'} || nil
  end
  
  def destroy_file(key)
    true || false
  end
  
  def save_file(key, body)
    mtime || false
  end
end