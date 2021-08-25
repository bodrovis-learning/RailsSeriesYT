# frozen_string_literal: true

module Internationalization
  extend ActiveSupport::Concern

  # rubocop:disable Metrics/BlockLength
  included do
    around_action :switch_locale

    private

    def switch_locale(&action)
      locale = locale_from_url || locale_from_headers || I18n.default_locale
      response.set_header 'Content-Language', locale
      I18n.with_locale locale, &action
    end

    # Adapted from https://github.com/rack/rack-contrib/blob/master/lib/rack/contrib/locale.rb
    def locale_from_url
      locale = params[:locale]

      return locale if I18n.available_locales.map(&:to_s).include?(locale)
    end

    def locale_from_headers
      header = request.env['HTTP_ACCEPT_LANGUAGE']

      return if header.nil?

      locales = parse_header header

      return if locales.empty?

      return locales.last unless I18n.enforce_available_locales

      detect_from_available locales
    end

    def parse_header(header)
      # rubocop:disable Style/MultilineBlockChain
      header.gsub(/\s+/, '').split(',').map do |language_tag|
        locale, quality = language_tag.split(/;q=/i)
        quality = quality ? quality.to_f : 1.0
        [locale, quality]
      end.reject do |(locale, quality)|
        locale == '*' || quality.zero?
      end.sort_by do |(_, quality)|
        quality
      end.map(&:first)
      # rubocop:enable Style/MultilineBlockChain
    end

    def detect_from_available(locales)
      locales.reverse.find { |l| I18n.available_locales.any? { |al| match?(al, l) } }
      I18n.available_locales.find { |al| match?(al, locale) } if locale
    end

    def match?(str1, str2)
      str1.to_s.casecmp(str2.to_s).zero?
    end

    def default_url_options
      { locale: I18n.locale }
    end
  end
  # rubocop:enable Metrics/BlockLength
end
