module Jekyll
  class Youtube < Liquid::Tag
    @url = nil

    VIDEO_URL = /(\S+)/i

    def initialize(tag_name, markup, tokens)
      super

      if markup =~ VIDEO_URL
        @url = $1
      end
    end

    def render(context)

      source = "<div class=\"video\">"

      source += "<div class=\"video-wrapper\" itemprop=\"video\">"
      source += "<iframe width=\"640\" height=\"480\" src=\"//www.youtube.com/embed/#{@url}?rel=0\" frameborder=\"0\" allowfullscreen></iframe>"
      source += "</div>"
      source += "</div>"

      source
    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::Youtube)