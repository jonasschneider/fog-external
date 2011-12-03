require 'fog/core/model'

module Fog
  module Storage
    class Bertrpc
      
      class Directory < Fog::Model
        identity  :key
  
        def destroy
          requires :key
          
          connection.remote.directories.destroy(identity)
          true
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
          true
        end
      end

    end
  end
end