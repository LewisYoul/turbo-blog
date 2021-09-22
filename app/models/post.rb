class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates_presence_of :title, :summary, :body, :parsed_body
  
  before_validation :parse_body

  private

  def parse_body
    self.parsed_body = MarkdownParser.new.parse(body)
  end
end
