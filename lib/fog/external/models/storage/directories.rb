require 'fog/core/collection'
require 'fog/external/models/storage/directory'

module Fog
  module Storage
    class External

      class Directories < Fog::Collection
        model Fog::Storage::External::Directory
  
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