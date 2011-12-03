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
                if key == 'mykey'
                  {:key => 'mykey'}
                else
                  nil
                end
              end
              
            end
          end
        end
        
      end
    end
  end
end