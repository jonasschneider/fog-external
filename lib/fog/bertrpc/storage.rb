require 'fog'
require 'fog/storage'

require 'fog-bertrpc'
require 'bertrpc'

module Fog
  module Storage
    class Bertrpc < Fog::Service

      requires :url

      model_path 'fog/bertrpc/models/storage'
      collection  :directories
      model       :directory
      #model       :file
      #collection  :files

      class Real
        def initialize(options={})
          require 'mime/types'
        end

        def service
          BERTRPC::Service.new('localhost', 9999)
        end
        
        def remote
          # directories.list
          # directories.create
          service.call
        end
      end

    end
  end
end