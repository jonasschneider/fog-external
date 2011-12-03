require 'fog/core/collection'
require 'fog/bertrpc/models/storage/directory'

module Fog
  module Storage
    class Bertrpc

      class Directories < Fog::Collection
        model Fog::Storage::Bertrpc::Directory
  
        def all
          # get list of servers
          load(data) # data is an array of attribute hashes
        end
  
        def get(identity)
          # get server matching id
          new(data) # data is an attribute hash
        rescue Excon::Errors::NotFound
          nil
        end
      end

    end
  end
end