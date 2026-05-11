class VideoProgressesController < ApplicationController
  before_action :authenticate_user!

  def upsert
    episode = CourseEpisode.find(params[:course_episode_id])
    progress = VideoProgress.find_or_initialize_by(
      user: current_user,
      course_episode: episode
    )

    progress.seconds_watched = params[:seconds_watched].to_i

    # Limitar al maximo de duracion + 10% buffer para evitar abuso
    max_seconds = episode.duration_seconds ? (episode.duration_seconds * 1.1).to_i : nil
    if max_seconds && progress.seconds_watched > max_seconds
      progress.seconds_watched = max_seconds
    end

    # Marcar como completado si vieron el 90% o más
    if episode.duration_seconds && episode.duration_seconds > 0
      watched_ratio = progress.seconds_watched.to_f / episode.duration_seconds
      progress.completed = true if watched_ratio >= 0.9
    end

    if progress.save
      render json: { status: "ok", seconds_watched: progress.seconds_watched, completed: progress.completed }
    else
      render json: { status: "error", errors: progress.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
