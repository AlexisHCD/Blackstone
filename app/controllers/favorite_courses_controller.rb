class FavoriteCoursesController < ApplicationController
  before_action :authenticate_user!

  def create
    @favorite = current_user.favorite_courses.build(course_id: params[:course_id])
    if @favorite.save
      redirect_back fallback_location: courses_path, notice: "Curso agregado a favoritos ⭐"
    else
      redirect_back fallback_location: courses_path, alert: "Ya está en tus favoritos"
    end
  end

  def destroy
    @favorite = current_user.favorite_courses.find_by(course_id: params[:id])
    @favorite&.destroy
    redirect_back fallback_location: courses_path, notice: "Curso removido de favoritos"
  end
end
