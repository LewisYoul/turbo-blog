class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @posts = Post.order(created_at: :desc)
  end
end
