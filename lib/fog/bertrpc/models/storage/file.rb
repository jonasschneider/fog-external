require 'fog/core/model'

module Fog
  module Storage
    class Bertrpc
      
      class File < Fog::Model
        identity  :key,             :aliases => 'Key'

        attribute :content_length,  :aliases => 'Content-Length', :type => :integer
        attribute :last_modified,   :aliases => 'Last-Modified'
        
        def directory
          @directory
        end
        
        def directory=(new_directory)
          @directory = new_directory
        end
        
        def body
          attributes[:body]
        end
        
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