class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user
      @user.create_reset_digest
      UserMailer.password_reset(@user).deliver_now
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  @user = User.find_by(email: params[:email])
  unless @user && @user.authenticated?(:reset, params[:id])
    redirect_to root_url
  end
end

def update
  @user = User.find_by(email: params[:email])
  if params[:user][:password].empty?
    @user.errors.add(:password, "can't be empty")
    render 'edit'
  elsif @user.update(user_params)
    log_in @user
    flash[:success] = "Password has been reset."
    redirect_to @user
  else
    render 'edit'
  end
end

private

def user_params
  params.require(:user).permit(:password, :password_confirmation)
end

end
