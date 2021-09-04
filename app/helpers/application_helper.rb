module ApplicationHelper
  def title
    content_for?(:title) ? content_for(:title) : "Lewis Youl"
  end

  def twitter_card
    if content_for?(:twitter_card)
      content_for(:twitter_card)
    else
      raw(
        <<-HTML
          <meta name="twitter:card" content="summary">
          <meta name="twitter:title" content="Lewis Youl">
          <meta name="twitter:description" content="A web development blog by some fella that lives in blighty">
          <meta name="twitter:image" content="https://miro.medium.com/max/1420/1*9hd_8qR0CMZ8L0pVbFLjDw.png">
          <meta name="twitter:site" content="@lewisyoul">
        HTML
      )
    end
  end
end
