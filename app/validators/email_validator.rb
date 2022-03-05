# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(rec, att, val)
    msg = I18n.t 'global.errors.invalid_format'
    rec.errors.add(att, (options[:message] || msg)) unless valid_email?(val)
  end

  private

  def valid_email?(value)
    URI::MailTo::EMAIL_REGEXP.match? value
  end
end
