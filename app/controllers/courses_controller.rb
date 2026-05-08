class CoursesController < ApplicationController
  def index
    @courses = Course.includes(:category, :course_episodes).all
  end

  def show
    @course = Course.find(params[:id])
    @episodes = @course.course_episodes.order(:position)
  end
end
