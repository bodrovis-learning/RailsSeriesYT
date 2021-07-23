class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ErrorHandling
  include Authentication
end
