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
      collection  :files
      model       :file

      class Real
        def initialize(options={})
          require 'mime/types'
        end

        def service
          # see spec/service_mock.rb for a rough spec
          BERTRPC::Service.new('localhost', 9999)
        end
        
        def remote
          service.call
        end
      end

    end
  end
end