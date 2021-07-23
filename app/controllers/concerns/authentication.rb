module Authentication
  extend ActiveSupport::Concern

  included do
    private
    
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]).decorate if session[:user_id].present?
    end

    def user_signed_in?
      current_user.present?
    end

    def require_authentication
      return if user_signed_in?

      flash[:warning] = "You are not signed in!"
      redirect_to root_path
    end

    def require_no_authentication
      return unless user_signed_in?

      flash[:warning] = "You are already signed in!"
      redirect_to root_path
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      session.delete :user_id
      @current_user = nil
    end

    helper_method :current_user, :user_signed_in?
  end
end