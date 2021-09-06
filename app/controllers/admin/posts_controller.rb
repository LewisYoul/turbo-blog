module Admin
  class PostsController < BaseController
    def new
      @post = Post.new
      @tags = Tag.order(name: :asc)
    end

    def create
      @post = Post.new(post_params)

      if @post.save
        redirect_to root_path, notice: 'Post created!'
      else
        render :new
      end
    end

    def edit
      @post = Post.friendly.find(params[:id])
      @tags = Tag.where.not(id: @post.tag_ids).order(name: :asc)
    end

    def update
      @post = Post.friendly.find(params[:id])

      if @post.update(post_params)
        redirect_to root_path, notice: 'Post updated!'
      else
        render :new
      end
    end

    def destroy
      post = Post.friendly.find(params[:id])

      post.destroy!

      redirect_to root_path, notice: 'Post deleted!'
    end

    private

    def post_params
      params.require(:post).permit(:title, :summary, :body, post_tags: { tag_ids: [] })
    end
  end
end