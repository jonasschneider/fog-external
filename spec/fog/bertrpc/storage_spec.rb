require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper'))

require 'fog/bertrpc/storage'

describe "fog-bertrpc" do
  it "works" do
    storage = Fog::Storage.new({
      :local_root => '~/fog',
      :provider   => 'Bertrpc'
    })
  end
end
