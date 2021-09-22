module Admin
  class PostsController < BaseController
    def new
      @post_tags = Post.none
      @post = Post.new
      @tags = Tag.order(name: :asc)
    end

    def create
      respond_to do |format|
        format.turbo_stream do
          result = PostsCreator.new(post_params).create_post

          if result.created?
            redirect_to root_path, notice: 'Post created!'
          else
            @post = result.post
            @post_tags = Post.where(id: post_params[:tag_ids])
            @tags = Tag.order(name: :asc)
          end
        end
      end
    end

    def edit
      @post = Post.friendly.find(params[:id])
      @tags = Tag.order(name: :asc)
    end

    def update
      respond_to do |format|
        format.turbo_stream do
          @post = Post.friendly.find(params[:id])

          result = PostsUpdater.new(@post, post_params).update_post

          if result.updated?
            redirect_to post_path(@post), notice: 'Post updated!'
          else
            @post_tags = Post.where(id: post_params[:tag_ids])
            @tags = Tag.order(name: :asc)
          end
        end
      end
    end

    def destroy
      post = Post.friendly.find(params[:id])

      post.destroy!

      redirect_to root_path, notice: 'Post deleted!'
    end

    private

    def post_params
      params.require(:post).permit(:title, :summary, :body, tag_ids: [])
    end
  end
end