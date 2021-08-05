# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def pagination(obj)
    # rubocop:disable Rails/OutputSafety
    raw(pagy_bootstrap_nav(obj)) if obj.pages > 1
    # rubocop:enable Rails/OutputSafety
  end

  def nav_tab(title, url, options = {})
    current_page = options.delete :current_page

    css_class = current_page == title ? 'text-secondary' : 'text-white'

    options[:class] = if options[:class]
                        "#{options[:class]} #{css_class}"
                      else
                        css_class
                      end

    link_to title, url, options
  end

  def currently_at(current_page = '')
    render partial: 'shared/menu', locals: { current_page: current_page }
  end

  def full_title(page_title = '')
    base_title = 'AskIt'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end
end
