class Admin::CourseEpisodesController < Admin::BaseController
  before_action :set_course
  before_action :set_episode, only: [:edit, :update, :destroy]

  def new
    @episode = @course.course_episodes.new
  end

  def create
    @episode = @course.course_episodes.new(episode_params)
    if @episode.save
      redirect_to admin_course_path(@course), notice: "Episodio creado."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @episode.update(episode_params)
      redirect_to admin_course_path(@course), notice: "Episodio actualizado."
    else
      render :edit
    end
  end

  def destroy
    @episode.destroy
    redirect_to admin_course_path(@course), notice: "Episodio eliminado."
  end

  private

  def set_course
    @course = Course.find_by!(slug: params[:course_id] || params[:course_slug] || params[:slug])
  end

  def set_episode
    @episode = @course.course_episodes.find(params[:id])
  end

  def episode_params
    params.require(:course_episode).permit(:title, :youtube_url, :duration_seconds, :position)
  end
end
