class PostsCreator
  def initialize(params)
    @params = params
  end

  def create_post
    post = Post.new(@params)

    Result.new(created: post.save, post: post)
  end

  private

  class Result
    attr_reader :post

    def initialize(created:, post:)
      @created = created
      @post = post
    end

    def created?
      @created
    end

    def errors
      @post.errors
    end
  end
end