module Admin
  class PostsPreviewController < BaseController
    def create
      @post = Post.new(post_params)
      @preview = params[:preview] == 'true'
      @parsed_body = MarkdownParser.new.parse(post_params[:body])
    end

    private

    def post_params
      params.require(:post).permit(:title, :summary, :body)
    end
  end
end