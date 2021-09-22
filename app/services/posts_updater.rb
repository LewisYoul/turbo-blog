class PostsUpdater
  def initialize(post, params)
    @post = post
    @params = params
  end

  def update_post
    Post.transaction do
      @post.post_tags.where.not(tag_id: @params[:tag_ids]).each(&:destroy!)

      @post.update!(@params)

      Result.new(updated: true, post: @post)
    end
  end

  class Result
    attr_reader :post

    def initialize(updated:, post:)
      @updated = updated
      @post = post
    end

    def updated?
      @updated
    end

    def errors
      @post.errors
    end
  end
end