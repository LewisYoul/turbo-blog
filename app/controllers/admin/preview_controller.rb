class Admin::PreviewController < Admin::BaseController
  def index
    respond_to do |format|
      format.turbo_stream do
        @parsed_content = MarkdownParser.new.parse(params[:markdown])
      end
    end
  end
end