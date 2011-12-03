# Fog-External
Use `fog-external`to use arbitrary Ruby objects as backend for `Fog::Storage`. This can mean a custom-written local-storage backend, or, without any more configuration, a BERT-RPC (or any other RPC implementation) remote call.

## Installation
    gem install fog-external

## Usage
    require 'fog/external/storage'
    
    storage = Fog::Storage.new({
      :provider   => 'External',
      :delegate   => BERTRPC::Service.new('localhost', 9999).call.fog
    })

You can then use `storage` just like any other Fog::Storage object, see [the Fog docs](http://fog.io/1.1.1/storage/) for what's possible.. The API is compatible to the one of `Fog::Local`.

The delegate must respond to a number of backend methods. The delegate in the above-example uses [BERTRPC][1] to call a server on localhost:9999, using the `fog` module name. For more information about using BERTRPC, see `examples/`.

## Copyright

(The MIT License)

Copyright © 2011 Jonas Schneider

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

  [1]: https://github.com/mojombo/bertrpc "BERT-RPC