class HomeController < ApplicationController
  PER_PAGE = 10.freeze
  FIRST_PAGE = 1.freeze

  def index
    @page = params[:page]&.to_i || FIRST_PAGE
    @next_page = @page + 1
    offset = PER_PAGE * (@page - 1)
    @posts = Post.includes(:tags)
      .order(created_at: :desc)
      .offset(offset)
      .limit(PER_PAGE)
    @has_next_page = @posts.size == PER_PAGE 
  end
end
