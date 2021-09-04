module Admin
  class PostsPreviewController < BaseController
    def create
      @post = Post.new(post_params)

      parse_body
    end

    def update
      @post = Post.friendly.find(params[:id])
      @post.assign_attributes(post_params)

      parse_body
    end

    private

    def post_params
      params.require(:post).permit(:title, :summary, :body)
    end

    def parse_body
      @preview = params[:preview] == 'true'
      @parsed_body = MarkdownParser.new.parse(post_params[:body])
    end
  end
end