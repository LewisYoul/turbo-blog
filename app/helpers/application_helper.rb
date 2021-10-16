class ActionView::Helpers::FormBuilder
  include ActionView::Helpers::OutputSafetyHelper

  def text_field_with_icon(method, options = {})
    raw(
      <<-HTML
        <div class="relative">
          <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
          </div>
          #{text_field(method, options)}
        </div>
      HTML
    )
  end

  def multi_select
    tags = Tag.order(name: :asc).map do |tag|
      <<-HTML
        <div data-action='click->multi_select#toggleSelection' data-multi_select-target='option' data-multi_select-selected-value='false' class='flex items-center pr-4 pl-1 px-3 py-1'>
          <span data-multi_select-target="spacer" class="h-4 w-4 mr-1"></span>
          <svg data-multi_select-target="check" class="h-4 w-4 mr-1 text-green-500 hidden" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
          </svg>
          <span>#{tag.name}</span>
        </div>
      HTML
    end.join

    raw(
      <<-HTML
        <div class="inline-block cursor-pointer relative whitespace-nowrap" data-controller="multi_select" data-multi_select-selected-class="bg-green-50" data-action="click->multi_select#toggle">
          <div class="flex items-center border border-pink-500 rounded-md px-3 py-2 text-sm">
            <span class="mr-1">Select</span>
            <svg data-multi_select-target="closedIcon" xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-pink-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
            </svg>
            <svg data-multi_select-target="openIcon" xmlns="http://www.w3.org/2000/svg" class="hidden h-4 w-4 text-pink-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7" />
            </svg>
          </div>
          <div data-multi_select-target="options" class="hidden mt-1 py-1 text-sm bg-white border border-pink-500 rounded-md absolute top-100 left-0">
            #{tags}
          </div>
        </div>
      HTML
    )
  end
end

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

  def basic_badge(tag)
    link_to(tag.name, search_index_path(tag_ids: tag.id), method: :get, class: "inline-flex items-center px-2 py-1 my-1 text-sm font-medium text-pink-600 hover:underline")
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
