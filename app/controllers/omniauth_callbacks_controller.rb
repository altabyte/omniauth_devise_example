class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    provider_callback(:facebook)
  end

  def linkedin
    provider_callback(:facebook)
  end

  def failure
    redirect_to root_path, alert: 'Failed to authenticate'
  end

  def after_sign_in_path_for(resource)
    if resource.temporary_email?
      register_user_email_path(resource)
    else
      super resource
    end
  end

  def register_email
    if request.patch? && params[:user]
      user = User.find(params[:id])
      if user
        user.skip_reconfirmation!
        user.email = (params.require(:user).permit(:email))[:email]
        if user.save
          sign_in(user, bypass: true)
          redirect_to root_path, notice: 'Your profile was successfully updated.'
        else
          @show_errors = true
        end
      end
    end
  end

  #---------------------------------------------------------------------------
  private

  def provider_callback(provider)
    @user = User.find_for_oauth(env['omniauth.auth'], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
