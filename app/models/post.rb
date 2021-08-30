class Post < ApplicationRecord
  validates_presence_of :title, :summary, :body, :parsed_body
end
