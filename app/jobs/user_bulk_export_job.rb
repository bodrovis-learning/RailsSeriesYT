# frozen_string_literal: true

class UserBulkExportJob < ApplicationJob
  queue_as :default

  def perform(initiator)
    stream = UserBulkExportService.call

    Admin::UserMailer.with(user: initiator, stream: stream)
                     .bulk_export_done.deliver_now
  end
end
