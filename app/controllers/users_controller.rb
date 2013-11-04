class UsersController < Devise::RegistrationsController
  authorize_resource :only =>[:edit, :update, :destroy]
  def show
    @user  = User.find(params[:id])
  end

  def index
     @users = User.paginate(page: params[:page])
  end

  def cancel 
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

end
