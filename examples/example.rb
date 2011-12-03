require 'rubygems'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'fog/external/storage'
require "bertrpc"

ROOT = '/tmp/fog-external-example-root'
Dir.chdir File.join(File.dirname(__FILE__), '..')

Dir.mkdir(ROOT) unless File.exists?(ROOT)

def run(cmd)
  puts "=> #{cmd}"
  system cmd
end

puts "Starting ernie on localhost:8000"
run "ernie -d -c examples/ernie.conf -P examples/ernie.pid -a /tmp/ernie.log"

puts "Ernie running."

storage = Fog::Storage.new({
  :provider   => 'External',
  :delegate   => BERTRPC::Service.new('localhost', 8000).call.fog
})

puts "Known directories: "
puts storage.directories.all.inspect

puts "Creating directory mydir/ ..."
puts storage.directories.create(key: 'mydir').save

puts "Known directories: "
puts storage.directories.all.inspect

puts "Stopping ernie on localhost:8000"
run "kill `cat examples/ernie.pid`"