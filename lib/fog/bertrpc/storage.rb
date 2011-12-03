require 'fog'
require 'fog/storage'

require 'fog-bertrpc'

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

        def connection
          BERTRPC::Service.new('localhost', 9999)
        end
      end

    end
  end
end