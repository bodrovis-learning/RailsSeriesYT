# frozen_string_literal: true

class UserBulkImportService < ApplicationService
  attr_reader :archive_key, :service

  # rubocop:disable Lint/MissingSuper
  def initialize(archive_key)
    @archive_key = archive_key
    @service = ActiveStorage::Blob.service
  end
  # rubocop:enable Lint/MissingSuper

  def call
    read_zip_entries do |entry|
      entry.get_input_stream do |f|
        User.import users_from(f.read), ignore: true
        f.close
      end
    end
  ensure
    service.delete archive_key
  end

  private

  def read_zip_entries
    return unless block_given?

    stream = zip_stream
    loop do
      entry = stream.get_next_entry

      break unless entry
      next unless entry.name.end_with? '.xlsx'

      yield entry
    end
  ensure
    stream.close
  end

  def zip_stream
    f = File.open service.path_for(archive_key)
    stream = Zip::InputStream.new(f)
    f.close
    stream
  end

  def users_from(data)
    sheet = RubyXL::Parser.parse_buffer(data)[0]
    sheet.map do |row|
      cells = row.cells[0..2].map { |c| c&.value.to_s }
      User.new name: cells[0],
               email: cells[1],
               password: cells[2],
               password_confirmation: cells[2]
    end
  end
end
