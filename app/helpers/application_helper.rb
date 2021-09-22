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

  def basic_badge(text)
    button_tag(text, class: "inline-flex items-center px-2 py-1 my-1 text-sm font-medium text-pink-600 hover:underline")
  end

  def form_tag(tag, tags)
    selected = tags.include?(tag)

    color_classes = selected ? 'bg-green-100 hover:bg-green-200' : 'bg-pink-100 hover:bg-pink-200'

    button_tag(type: :button, data: { tags_target: 'tag', tags_id_value: tag.id, action: 'click->tags#toggle', tags_name_value: tag.name }, class: "inline-flex items-center px-2 py-1 my-1 rounded-md text-sm font-medium text-gray-800 #{color_classes}") do
      concat content_tag(:span, tag.name)

      icon_class = selected ? 'text-green-400' : 'text-pink-400'

      concat(
        content_tag(:span, data: { tags_target: 'iconWrapper' }, class: "flex-shrink-0 ml-0.5 h-4 w-4 rounded-md inline-flex items-center justify-center focus:outline-none #{icon_class}") do
          if selected
            raw(
              <<-HTML
                <svg data-tags-target="check" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <svg data-tags-target="cross" xmlns="http://www.w3.org/2000/svg" class="hidden fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              HTML
            )
          else
            raw(
              <<-HTML
                <svg data-tags-target="check" xmlns="http://www.w3.org/2000/svg" class="hidden" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <svg data-tags-target="cross" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              HTML
            )
          end
        end
      )
    end
  end
end
