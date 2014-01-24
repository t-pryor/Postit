class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
  #show the post form
  end

  def create
    #handle the submission of the new post form
  end

  def edit
    #display the edit post form
  end

  def update
    #handle submission of edit post form
  end

end
