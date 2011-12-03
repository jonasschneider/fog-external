require 'pp'
require 'rubygems'
require 'bundler'
Bundler.setup :default, :development

require "rspec"

project_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$:.unshift File.join(project_root, 'lib')