module Admin  
  class PostTagsController < BaseController
    def create
      @post_tag = PostTag.create!(post_id: params[:post_id], tag_id: params[:tag_id])
      @tags = Tag.where.not(id: Post.find(params[:post_id]).tag_ids).order(name: :asc)
    end
    
    def destroy
      @post_tag = PostTag.find(params[:id])
      @post_tag.destroy!
    end
  end
end