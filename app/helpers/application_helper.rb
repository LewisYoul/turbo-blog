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
          <meta name="twitter:title" content="Lewis Youl - Web Development Blog">
          <meta name="twitter:description" content="Providing content on JavScript and Ruby on Rails to improve developer happiness, productivity and application performance">
          <meta name="twitter:image" content="https://miro.medium.com/max/1420/1*9hd_8qR0CMZ8L0pVbFLjDw.png">
          <meta name="twitter:site" content="@lewisyoul">
        HTML
      )
    end
  end
end
