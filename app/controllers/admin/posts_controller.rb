module Admin
  class PostsController < BaseController
    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)

      if @post.save
        redirect_to root_path, notice: 'Post created!'
      else
        render :new
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :summary, :body)
    end
  end
end