class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(created_at: :desc)
  end

  def toggle_admin
    @user = User.find(params[:id])

    if @user == current_user
      redirect_to admin_users_path, alert: "No puedes revocar tus propios permisos de administrador."
    else
      @user.update(admin: !@user.admin?)
      status = @user.admin? ? "ahora es administrador" : "ya no es administrador"
      redirect_to admin_users_path, notice: "El usuario #{@user.name || @user.email} #{status}."
    end
  end
end
