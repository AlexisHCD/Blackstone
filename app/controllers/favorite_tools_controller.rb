class FavoriteToolsController < ApplicationController
  before_action :authenticate_user!

  def create
    @favorite = current_user.favorite_tools.build(tool_id: params[:tool_id])
    if @favorite.save
      redirect_back fallback_location: tools_path, notice: "Herramienta agregada a favoritos ⭐"
    else
      redirect_back fallback_location: tools_path, alert: "Ya está en tus favoritos"
    end
  end

  def destroy
    @favorite = current_user.favorite_tools.find_by(tool_id: params[:id])
    @favorite&.destroy
    redirect_back fallback_location: tools_path, notice: "Herramienta removida de favoritos"
  end
end
