require "base64"
require "bertrpc"

class BertrpcBackend
  METHODS = %w(create_directory list_directories get_directory destroy_directory list_files head_file get_file destroy_file save_file)
  
  def initialize(svc)
    @service = svc
    @module = @service.call.fog
  end
  
  METHODS.each do |m|
    define_method m do |*args|
      @module.send m, *args
    end
  end
  
  def get_file(key)
    res = @module.get_file(key)
    res[:body] = Base64.decode64(res[:body])
    res
  end
  
  def save_file(key, body)
    body = Base64.encode64(body)
    @module.save_file(key, body)
  end
end