require 'ernie'
ROOT = '/tmp/fog-external-example-root'
# ported from Fog's Local storage

module Fog
  def create_directory(key)
    if ::File.directory?(path_to(key))
      false
    else
      Dir.mkdir path_to(key)
    end
  end
  
  def list_directories
    data = Dir.entries(ROOT).select do |entry|
      entry[0...1] != '.' && ::File.directory?(path_to(entry))
    end.map do |entry|
      {:key => entry}
    end
  end
  
  def get_directory(key)
    if ::File.directory?(path_to(key))
      { key: key }
    else
      nil
    end
  end
  
  def destroy_directory(key)
    if ::File.directory?(path_to(key))
      Dir.rmdir(path_to(key))
      true
    else
      false
    end
  end
  
  
  def list_files(dir_key)
    data = nil
    Dir.chdir(path_to(dir_key)) do
      data = Dir.glob('**/*').reject do |file|
        ::File.directory?(file)
      end.map do |key|
        path = path_to(key)
        {
          :content_length => ::File.size(path),
          :key            => key,
          :last_modified  => ::File.mtime(path)
        }
      end
    end
    data
  end
  
  def head_file(key)
    path = path_to(key)
    if ::File.exists?(path)
      {
        :content_length => ::File.size(path),
        :key            => key,
        :last_modified  => ::File.mtime(path)
      }
    else
      nil
    end
  end
  
  def get_file(key)
    path = path_to(key)
    if ::File.exists?(path)
      {
        :content_length => ::File.size(path),
        :key            => key,
        :last_modified  => ::File.mtime(path),
        :body           => ::File.read(path)
      }
    else
      nil
    end
  end
  
  def destroy_file(key)
    path = path_to(key)
    
    if ::File.exists?(path)
      ::File.delete(path)
      true
    else
      false
    end
  end
  
  def save_file(key, body)
    path = path_to(key)
    
    FileUtils.mkdir_p(File.dirname(path))
    
    file = ::File.new(path, 'wb')
    file.write(body)
    file.close
    
    ::File.mtime(path)
  end
  
  private
  
  def path_to(entry)
    ::File.join(ROOT, entry)
  end
end

Ernie.expose(:fog, Fog)