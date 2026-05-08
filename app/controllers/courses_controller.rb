class CoursesController < ApplicationController
  def index
    @courses = Course.includes(:category, :course_episodes).all
  end

  def show
    @course = Course.find(params[:id])
    @episodes = @course.course_episodes.order(:position)

    # Cargar progreso del usuario si está logueado
    if user_signed_in?
      @progresses = VideoProgress.where(
        user: current_user,
        course_episode_id: @episodes.pluck(:id)
      ).index_by(&:course_episode_id)
    else
      @progresses = {}
    end
  end
end
