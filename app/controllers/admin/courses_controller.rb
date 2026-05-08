class Admin::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :create, :edit, :update]

  def index
    @courses = Course.includes(:category, :course_episodes).all
  end

  def show
    @episodes = @course.course_episodes.order(:position)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_courses_path, notice: "Curso creado."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to admin_courses_path, notice: "Curso actualizado."
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to admin_courses_path, notice: "Curso eliminado."
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def course_params
    params.require(:course).permit(:title, :description, :is_series, :category_id)
  end
end
