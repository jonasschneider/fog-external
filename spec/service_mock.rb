class ServiceMock
  def call
    @o ||= Object.new.tap do |o|
      o.instance_eval do
        
        def directories
          @o ||= Object.new.tap do |o|
            o.instance_eval do
              
              def create(key)
                true
              end
              
              def list
                [{:key => 'mykey'}]
              end
              
              def get(key)
                {:key => 'mykey'} || nil
              end
              
              def destroy(key)
                true
              end
              
            end
          end
        end
        
        def files
          @o ||= Object.new.tap do |o|
            o.instance_eval do
              
              def list(dir_key)
                [{:key => 'mykey/a', :content_length => 5, :last_modified => Time.now}]
              end
              
              def get(key)
                {:key => 'mykey/a', :content_length => 5, :last_modified => Time.now, :body => 'asdf'} || nil
              end
              
            end
          end
        end
        
      end
    end
  end
end