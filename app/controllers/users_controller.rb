class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザーが登録されました"
      email = @user.email.downcase
      password = @user.password
        if login(email,password)
          redirect_to tasks_path(current_user)
        end 
    else
      flash.now[:danger] = "ユーザーが登録されませんでした"
      render :new 
    end 
    

  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end 
end
