class Admin::ToolsController < Admin::BaseController
  before_action :set_tool, only: [:edit, :update, :destroy]
  before_action :set_categories, only: [:new, :create, :edit, :update]

  def index
    @tools = Tool.all
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      redirect_to admin_tools_path, notice: "Herramienta creada."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tool.update(tool_params)
      redirect_to admin_tools_path, notice: "Herramienta actualizada."
    else
      render :edit
    end
  end

  def destroy
    @tool.destroy
    redirect_to admin_tools_path, notice: "Herramienta eliminada."
  end

  private

  def set_tool
    @tool = Tool.find_by!(slug: params[:id] || params[:slug])
  end

  def set_categories
    @categories = Category.all
  end

  def tool_params
    params.require(:tool).permit(
      :name,
      :description,
      :website_url,
      :open_source,
      :free_tier,
      :platform,
      :level,
      :category_id,
      :logo
    )
  end
end
