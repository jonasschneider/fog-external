require 'rubygems'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'fog/external/storage'

Dir.chdir File.join(File.dirname(__FILE__), '..')

require "./examples/bertrpc_backend"

ROOT = '/tmp/fog-external-example-root'
Dir.mkdir(ROOT) unless File.exists?(ROOT)

def run(cmd)
  puts "=> #{cmd}"
  system cmd
end

puts "Starting ernie on localhost:8000"
run "ernie -d -c examples/ernie.conf -P /tmp/ernie.pid -a /tmp/ernie.log"

puts "Ernie running."

storage = Fog::Storage.new({
  :provider   => 'External',
  :delegate   => BertrpcBackend.new(BERTRPC::Service.new('localhost', 8000))
})

puts "Known directories: "
puts storage.directories.all.inspect

puts "Creating directory mydir/ ..."
puts storage.directories.create(key: 'mydir').save

puts "Known directories: "
puts storage.directories.all.inspect

print "Creating mydir/test.txt with content 'ohai' ..."
f = storage.directories.get('mydir').files.new(key: 'test.txt')
f.body = 'ohai'
if f.save
  puts "done."
else
  puts "error."
end

print "Contents of mydir/test.txt: "
f = storage.directories.get('/').files.get('mydir/test.txt')
puts f.body

puts "Stopping ernie on localhost:8000"
run "kill `cat examples/ernie.pid`"