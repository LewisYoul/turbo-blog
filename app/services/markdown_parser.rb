require 'rouge/plugins/redcarpet'

class HTMLRenderer < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

class MarkdownParser
  def initialize
    @parser = Redcarpet::Markdown.new(HTMLRenderer.new, fenced_code_blocks: true)
  end

  def parse(markdown)
    @parser.render(markdown)
  end
end