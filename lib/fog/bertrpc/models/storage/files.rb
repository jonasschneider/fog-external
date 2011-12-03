require 'fog/core/collection'
require 'fog/bertrpc/models/storage/file'

module Fog
  module Storage
    class Bertrpc

      class Files < Fog::Collection
        attribute :directory
        model Fog::Storage::Bertrpc::File
  
        def all
          requires :directory
          
          load(connection.remote.files.list(directory.key))
        end
  
        def get(id)
          requires :directory
          
          data = connection.remote.directories.get(file_key(id))
          if data
            new(data)
          else
            nil
          end
        end
        
        def head(id) # hackish!
          requires :directory
          real_key = file_key(id)
          if data = connection.remote.files.list(directory.key).detect{|c|c[:key] == real_key}
            new(data)
          else
            nil
          end
        end
        
        def new(attributes = {})
          requires :directory
          super({ :directory => directory }.merge!(attributes))
        end
      
        
        private
        
        def file_key(id)
          ::File.join(directory.key, id)
        end
      end

    end
  end
end