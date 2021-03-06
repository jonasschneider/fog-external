require 'fog/core/model'
require "base64"

module Fog
  module Storage
    class External
      
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
        
        def content_type
          @content_type ||= begin
            unless (mime_types = ::MIME::Types.of(key)).empty?
              mime_types.first.content_type
            end
          end
        end
        
        def body
          attributes[:body] ||= if last_modified
            directory.files.get(identity).body
          else
            ''
          end
        end
        
        def body=(new_body)
          attributes[:body] = new_body
        end
        
        def destroy
          requires :key, :directory
          
          connection.remote.destroy_file(full_key)
          true
        end
        
        def public=(new_public)
          new_public
        end
        
        def public_url
          nil
        end
  
        def save
          requires :body, :directory, :key
          body_string = body.respond_to?(:read) ? body.read : body
          if res = connection.remote.save_file(full_key, body_string)
            merge_attributes(
              :content_length => Fog::Storage.get_body_size(body),
              :last_modified  => res
            )
            true
          else
            false
          end
        end
        
        private
        
        def full_key
          ::File.join(directory.key, key)
        end
      end

    end
  end
end