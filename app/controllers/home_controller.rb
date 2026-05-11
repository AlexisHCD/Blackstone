class HomeController < ApplicationController
  def index
    @featured_item = FeaturedItem.find_by(featured_on: Date.today)
    
    if @featured_item.nil?
      random_tool = Tool.order("RANDOM()").first
      if random_tool
        @featured_item = FeaturedItem.create(tool: random_tool, featured_on: Date.today)
      end
    end

    @categories = Category.includes(:tools, :courses).all
  end
end
