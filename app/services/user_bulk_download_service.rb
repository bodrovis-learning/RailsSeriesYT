class UserBulkDownloadService < ApplicationService
  def call
    renderer = ActionController::Base.new
    compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      User.order(created_at: :desc).each do |user|
        zos.put_next_entry "user_#{user.id}.xlsx"
        zos.print renderer.render_to_string(
          layout: false, handlers: [:axlsx], formats: [:xlsx], template: "admin/users/user", locals: { user: user }
        )
      end
    end

    compressed_filestream.rewind
    ActiveStorage::Blob.create_and_upload! io: compressed_filestream, filename: 'users.zip'
  end
end