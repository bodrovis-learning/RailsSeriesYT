# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    def authorize(record, query = nil)
      super([:admin, record], query)
    end
  end
end
