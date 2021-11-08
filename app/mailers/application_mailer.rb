# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin@askit.com'
  layout 'mailer'
end
