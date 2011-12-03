require 'fog'
require 'fog/storage'

require 'fog-bertrpc'

module Fog
  module Storage
    class Bertrpc < Fog::Service

      requires :local_root

      model_path 'fog/local/bertrpc/storage'
      #collection  :directories
      #model       :directory
      #model       :file
      #collection  :files

      class Real

        def initialize(options={})
          require 'mime/types'
          @local_root = ::File.expand_path(options[:local_root])
        end

        def local_root
          @local_root
        end

        def path_to(partial)
          ::File.join(@local_root, partial)
        end
      end

    end
  end
end