# frozen_string_literal: true

module Admin
  class UserMailer < ApplicationMailer
    def bulk_import_done
      @user = params[:user]

      mail to: @user.email, subject: I18n.t('admin.user_mailer.bulk_import_done.subject')
    end

    def bulk_import_fail
      @error = params[:error]
      @user = params[:user]

      mail to: @user.email, subject: I18n.t('admin.user_mailer.bulk_import_fail.subject')
    end
  end
end
