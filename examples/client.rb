require 'rubygems'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'fog/external/storage'
require "bertrpc"


Dir.chdir File.join(File.dirname(__FILE__), '..')

def run(cmd)
  puts "=> #{cmd}"
  system cmd
end

puts "Starting ernie on localhost:8000"
run "ernie -d -c examples/ernie.conf -P examples/ernie.pid"

puts "Ernie running."

storage = Fog::Storage.new({
  :provider   => 'External',
  :delegate   => BERTRPC::Service.new('localhost', 8000).call.fog
})

puts "Known directories: "
puts storage.directories.all.inspect

puts "Creating directory mydir/ ..."
storage.directories.create key: 'mydir'

puts "Known directories: "
puts storage.directories.all.inspect

puts "Stopping ernie on localhost:8000"
run "kill `cat examples/ernie.pid`"