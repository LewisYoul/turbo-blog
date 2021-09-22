class HomeController < ApplicationController
  def index
    @posts = Post.includes(:tags).order(created_at: :desc)
  end
end
