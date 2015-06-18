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

      source = "<div class=\"video\" itemprop=\"video\" itemscope itemtype=\"http://schema.org/VideoObject\">"
      source += "<div class=\"video-wrapper\">"
      source += "<iframe itemprop=\"embedUrl\" width=\"640\" height=\"480\" src=\"//www.youtube.com/embed/#{@url}?rel=0\" frameborder=\"0\" allowfullscreen></iframe>"
      source += "</div>"
      source += "</div>"

      source
    end
  end

  class Vimeo < Liquid::Tag
    @url = nil

    VIDEO_URL = /(\S+)/i

    def initialize(tag_name, markup, tokens)
      super

      if markup =~ VIDEO_URL
        @url = $1
      end
    end

    def render(context)

      source = "<div class=\"video\" itemprop=\"video\" itemscope itemtype=\"http://schema.org/VideoObject\">"
      source += "<div class=\"video-wrapper\">"
      source += "<iframe itemprop=\"embedUrl\" width=\"640\" height=\"480\" src=\"https://player.vimeo.com/video/#{@url}?portrait=0\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
      source += "</div>"
      source += "</div>"

      source
    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::Youtube)
Liquid::Template.register_tag('vimeo', Jekyll::Vimeo)