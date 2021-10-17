# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authorization
  include Pagy::Backend
  include ErrorHandling
  include Authentication
  include Internationalization
end
