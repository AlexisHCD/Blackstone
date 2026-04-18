class ToolsController < ApplicationController
  def index
    @tools = Tool.all
  end

  def new
    @tool = Tool.new
    @categories = Category.all
  end

  def create
    @tool = Tool.new(tool_params)

    if @tool.save
      redirect_to @tool, notice: "Herramienta creada"
    else
      @categories = Category.all
      render :new
    end
  end

  def show
    @tool = Tool.find(params[:id])
  end

  private

  def tool_params
    params.require(:tool).permit(
      :name,
      :description,
      :website_url,
      :open_source,
      :free_tier,
      :platform,
      :level,
      :category_id
    )
  end
end