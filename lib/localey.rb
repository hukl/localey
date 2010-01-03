class Localey
  
  def initialize app
    @app = app
  end
  
  def call env
    locale      = nil
    locale      = env['PATH_INFO'].match(/^\/([a-zA-Z-]{2,2})/)[1]
    I18n.locale = locale
    
    env['PATH_INFO'].sub!(/\/[a-zA-Z]{2,2}\//, "/")
    
    status, headers, response = @app.call(env)
    [status, headers, response]
  end
  
end


module ActionDispatch
  module Routing
    class RouteSet
      
      alias_method :generate_old, :generate
      
      def generate(options, recall = {}, method = :generate)
        locale = options.delete(:locale)
        locale ||= I18n.locale
        result = generate_old( options, recall, method )
        result.sub(/^\//, "/#{locale}/")
      end
    end
  end
end

