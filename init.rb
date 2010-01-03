# Include hook code here

require 'localey'
require 'localey/route_set'

Three::Application.configure do
  
  config.middleware.use "Localey"
  
end