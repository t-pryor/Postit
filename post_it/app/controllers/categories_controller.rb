class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def index
    @categories = Category.all

    respond_to do |format|
      format.json do
        render :json => @categories.to_json(:only => 'name')
      end
      format.xml do
        render :xml => @categories.to_xml(:only => 'name')
      end
    end

  end


  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Your category was created"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @category = Category.find_by(:slug => params[:id])
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end

end