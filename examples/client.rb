require 'bertrpc'

svc = BERTRPC::Service.new('localhost', 9999)
svc.call.ext.add(1, 2)