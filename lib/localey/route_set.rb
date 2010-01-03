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