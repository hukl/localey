class Localey
  
  def initialize app
    @app = app
  end
  
  def call env
    env = filter_locale( env )
    
    status, headers, response = @app.call(env)
    [status, headers, response]
  end
  
  def filter_locale env
    locale = env['PATH_INFO'].match(/^\/([\w-]+)\//)[1] rescue nil
    
    if locale and I18n::Locale::Tag::Rfc4646.tag( locale )
      I18n.locale = locale
      env['PATH_INFO'].sub!(/^\/([\w-]+)\//, "/")
    end
    
    env
  end
  
end