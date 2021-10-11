class SearchController < ApplicationController
  PER_PAGE = 10.freeze
  FIRST_PAGE = 1.freeze

  def index
    @page = params[:page]&.to_i || FIRST_PAGE
    @next_page = @page + 1
    offset = PER_PAGE * (@page - 1)
    @posts = Post.includes(:tags)

    if params[:search_term]
      @posts = @posts.where("title ILIKE ?", "%#{params[:search_term]}%")
    end

    if params[:tag_ids]
      @posts = @posts.joins(:post_tags).where(post_tags: { tag_id: params[:tag_ids] } )
    end

    @posts = @posts.order(created_at: :desc)
      .offset(offset)
      .limit(PER_PAGE)

    @has_next_page = @posts.size == PER_PAGE

    @tags = Tag.all
    @selected_tags = Tag.where(id: params[:tag_ids])

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "posts_#{@page}",
          partial: 'posts/posts',
          locals: { next_page_path: :search_index_path }
        )
      end
    end
  end
end