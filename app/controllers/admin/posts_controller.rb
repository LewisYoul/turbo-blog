module Admin
  class PostsController < BaseController
    def new
      @post = Post.new
    end

    def create

    end
  end
end