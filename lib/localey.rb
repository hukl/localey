class Localey
  
  def initialize app
    @app = app
  end
  
  def call env
    locale = env['PATH_INFO'].match(/^\/([\w-]+)\//)[1] rescue nil
    
    if locale and I18n::Locale::Tag::Rfc4646.tag( locale )
      I18n.locale = locale
      env['PATH_INFO'].sub!(/^\/([\w-]+)\//, "/")
    end
    
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

