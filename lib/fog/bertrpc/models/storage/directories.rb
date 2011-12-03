require 'fog/core/collection'
require 'fog/bertrpc/models/storage/directory'

module Fog
  module Storage
    class Bertrpc

      class Directories < Fog::Collection
        model Fog::Storage::Bertrpc::Directory
  
        def all
          load(connection.remote.directories.list)
        end
  
        def get(id)
          data = connection.remote.directories.get(id)
          if data
            new(data)
          else
            nil
          end
        end
      end

    end
  end
end