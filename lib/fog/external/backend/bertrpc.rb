require "bertrpc"

module Fog
  module External
    module Backend
      
      class Bertrpc
        def initialize(host, port)
          @service = BERTRPC::Service.new(host, port)
          @module = @service.call.fog
        end
        
        METHODS = %w(create_directory list_directories get_directory destroy_directory list_files head_file get_file destroy_file save_file)
        
        METHODS.each do |m|
          define_method m do |*args|
            @module.send m, *args
          end
        end
      
        def get_file(key)
          res = @module.get_file(key)
          return nil if res.nil?
          res[:body] = Base64.decode64(res[:body])
          res
        end
        
        def save_file(key, body)
          body = Base64.encode64(body)
          @module.save_file(key, body)
        end
      end
      
    end
  end
end
      