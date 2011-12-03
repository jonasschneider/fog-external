require "fog-bertrpc/version"

module Fog
  module Storage
     def self.new(attributes) # monkey patch to add :bertrpc
      attributes = attributes.dup # prevent delete from having side effects
      case provider = attributes.delete(:provider).to_s.downcase.to_sym
      when :aws
        require 'fog/aws/storage'
        Fog::Storage::AWS.new(attributes)
      when :google
        require 'fog/google/storage'
        Fog::Storage::Google.new(attributes)
      when :local
        require 'fog/local/storage'
        Fog::Storage::Local.new(attributes)
      when :ninefold
        require 'fog/ninefold/storage'
        Fog::Storage::Ninefold.new(attributes)
      when :rackspace
        require 'fog/rackspace/storage'
        Fog::Storage::Rackspace.new(attributes)
      when :bertrpc
        require 'fog/bertrpc/storage'
        Fog::Storage::Bertrpc.new(attributes)
      else
        raise ArgumentError.new("#{provider} is not a recognized storage provider")
      end
    end
  end
end
