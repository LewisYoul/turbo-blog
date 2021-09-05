module Admin
  class TagsController < BaseController
    def index
      @tag = Tag.new
      @tags = Tag.order(name: :asc)
    end

    def new
      @tag = Tag.new
    end

    def create
      @tag = Tag.new(tag_params)

      if @tag.save
        @tag = Tag.new
        @tags = Tag.order(name: :asc)
      else
        render :new
      end
    end

    def destroy
      @tag = Tag.find(params[:id])
      @tag.destroy!
    end

    private

    def tag_params
      params.require(:tag).permit(:name)
    end
  end
end