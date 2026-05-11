class Admin::DashboardController < Admin::BaseController
  def index
    @featured = FeaturedItem.find_by(featured_on: Date.today)
    @tools = Tool.order(:name)
  end

  def update_featured
    tool = Tool.find_by!(slug: params[:tool_id] || params[:tool_slug])
    featured = FeaturedItem.find_or_initialize_by(featured_on: Date.today)
    featured.update!(tool: tool)
    redirect_to admin_root_path, notice: "Herramienta destacada actualizada: #{tool.name}"
  end
end
