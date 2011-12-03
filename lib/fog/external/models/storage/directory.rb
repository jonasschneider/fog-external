require 'fog/core/model'
require 'fog/external/models/storage/files'

module Fog
  module Storage
    class External
      
      class Directory < Fog::Model
        identity  :key
  
        def destroy
          requires :key
          
          connection.remote.directories.destroy(identity)
          true
        end
        
        def files
          @files ||= begin
            Fog::Storage::External::Files.new(
              :directory    => self,
              :connection   => connection
            )
          end
        end
        
        def public=(new_public)
          new_public
        end
        
        def public_url
          nil
        end
  
        def save
          requires :key
          
          connection.remote.directories.create(identity)
        end
      end

    end
  end
end