class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorite_tools = current_user.favorited_tools.includes(:category)
    @favorite_courses = current_user.favorited_courses.includes(:category, :course_episodes)
  end
end
