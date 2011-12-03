require 'fog/core/model'

module Fog
  module Storage
    class Bertrpc
      
      class Directory < Fog::Model
        identity  :id
  
        def destroy
          requires :identity
          connection.destroy_server(identity)
          true
        end
  
        def ready?
          state == 'running'
        end
  
        def save
          requires ...
          connection.create_server(options)
          true
        end
      end

    end
  end
end