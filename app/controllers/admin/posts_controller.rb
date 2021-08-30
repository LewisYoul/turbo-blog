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

    def edit
      @post = Post.find(params[:id])
    end

    def update
      @post = Post.find(params[:id])

      if @post.update(post_params)
        redirect_to root_path, notice: 'Post updated!'
      else
        render :new
      end
    end

    def destroy
      post = Post.find(params[:id])

      post.destroy!

      redirect_to root_path, notice: 'Post deleted!'
    end

    private

    def post_params
      params.require(:post).permit(:title, :summary, :body)
    end
  end
end