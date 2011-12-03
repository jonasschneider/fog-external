require 'rubygems'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'fog/external/storage'
require "bertrpc"

storage = Fog::Storage.new({
  :provider   => 'External',
  :delegate   => BERTRPC::Service.new('localhost', 8000).call.fog
})

puts storage.directories.all.inspect