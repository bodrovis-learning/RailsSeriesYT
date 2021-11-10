# frozen_string_literal: true

class UserBulkExportService < ApplicationService
  def call
    compressed_filestream = output_stream

    compressed_filestream.rewind
    compressed_filestream
  end

  private

  def output_stream
    renderer = ActionController::Base.new

    Zip::OutputStream.write_buffer do |zos|
      User.order(created_at: :desc).each do |user|
        zos.put_next_entry "user_#{user.id}.xlsx"
        zos.print renderer.render_to_string(
          layout: false, handlers: [:axlsx], formats: [:xlsx], template: 'admin/users/user', locals: { user: user }
        )
      end
    end
  end
end
