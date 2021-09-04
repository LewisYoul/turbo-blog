module ApplicationHelper
  def title
    content_for?(:title) ? content_for(:title) : "Lewis Youl"
  end

  def twitter_card
    content_for(:twitter_card) if content_for?(:twitter_card)
  end
end
