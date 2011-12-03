require 'fog'
require 'fog/storage'

require 'fog-external'

module Fog
  module Storage
    class External < Fog::Service

      requires :delegate

      model_path 'fog/external/models/storage'
      collection  :directories
      model       :directory
      collection  :files
      model       :file

      class Real
        def initialize(options={})
          require 'mime/types'
          @delegate = options[:delegate]
        end
        
        def remote
          @delegate
        end
      end

    end
  end
end