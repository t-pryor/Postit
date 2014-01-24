class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse

    respond_to do |format|
      format.html
      format.json do
        render :json => @posts.to_json(:except => 'id')
      end
      format.xml do
        render :xml => @posts.to_xml(:except => 'id')
      end
    end

  end

  def show
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json do
        render :json => @post.to_json(:except => ['id'])
      end
      format.xml do
        render :xml => @post.to_xml(:except => ['id'])
      end
    end


  end


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render :new
    end

  end


  def edit; end


  def update

    if @post.update(post_params)
      flash[:notice] = 'The post was updated'
      redirect_to post_url(@post.id)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = 'Your vote was counted.'
        else
          flash[:error] =  'You can only vote on a post once.'
        end
        redirect_to :back
      end
      format.js
    end

  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :description, :category_ids)
    end

    def set_post
      @post = Post.find_by(:slug => params[:id])
    end
end



