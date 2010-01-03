# Include hook code here

require 'localey'

Three::Application.configure do
  
  config.middleware.use "Localey"
  
end