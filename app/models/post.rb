class Post < ApplicationRecord
  validates_presence_of :title, :summary, :body, :parsed_body
  
  before_validation :parse_body

  private

  def parse_body
    self.parsed_body = MarkdownParser.new.parse(body)
  end
end
