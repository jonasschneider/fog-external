# WARNING: Running this file will access /tmp/ernie.pid, /tmp/ernie.log and /tmp/fog-bertrpc-handler.
# Make sure you are not using any of these paths.
require 'rubygems'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'fog/external/storage'
require 'fog/external/backend/bertrpc'

Dir.chdir File.join(File.dirname(__FILE__), '..')

ROOT = '/tmp/fog-bertrpc-handler'
Dir.mkdir(ROOT) unless File.exists?(ROOT)

def run(cmd)
  puts "=> #{cmd}"
  system cmd
end

puts "Starting ernie on localhost:8000"
run "ernie -d -c examples/ernie.conf -P /tmp/ernie.pid -a /tmp/ernie.log"

puts "Ernie running."

begin

storage = Fog::Storage.new({
  :provider   => 'External',
  :delegate   => Fog::External::Backend::Bertrpc.new('localhost', 8000)
})

puts "Known directories: "
puts storage.directories.all.inspect

print "Creating directory mydir/ ..."
dir = storage.directories.new(key: 'mydir')
puts dir.save

puts "Known directories: "
puts storage.directories.all.inspect

print "Creating mydir/test.txt with content 'ohai' ..."
f = dir.files.new(key: 'test.txt')
f.body = 'ohai'
if f.save
  puts "done."
else
  puts "error."
end

print "Contents of mydir/test.txt: "
f = storage.directories.get('/').files.get('mydir/test.txt')
puts f.body

puts "Destroying mydir/test.txt"
f.destroy

puts "Destroying mydir/"
dir.destroy

puts "Known directories: "
puts storage.directories.all.inspect

ensure
  puts "Stopping ernie on localhost:8000"
  run "kill `cat /tmp/ernie.pid`"
end
