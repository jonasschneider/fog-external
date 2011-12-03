require 'rubygems'
require 'ernie'

module Ext
  def add(a, b)
    a + b
  end
end

class Ernie::IO
  def self.new *args
    if args[0] == 3
      $stdin
    elsif args[0] == 4
      $stdout
    else
      IO.new(*args)
    end
  end
end

#Ernie.expose(:directories, Ext)
Ernie.expose(:ext, Ext)