class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Registration was successful."
      redirect_to new_session_path
    else
      render_message(:danger, :unprocessable_entity, @user.errors.full_messages.join("\n"))
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :email_address, :password)
  end
end
