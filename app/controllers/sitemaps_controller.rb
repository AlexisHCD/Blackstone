class SitemapsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @categories = Category.all
    @tools = Tool.all
    @courses = Course.all

    render layout: false, content_type: "application/xml"
  end
end
