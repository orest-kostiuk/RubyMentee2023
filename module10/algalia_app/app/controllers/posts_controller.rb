class PostsController < ApplicationController
  def index
    @posts = Post.q_search(params[:search])
  end
end
