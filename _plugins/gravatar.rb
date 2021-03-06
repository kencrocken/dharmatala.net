# Courtsey of http://blog.sorryapp.com/blogging-with-jekyll/2014/02/13/add-author-gravatars-to-your-jekyll-site.html
require 'digest/md5'

module Jekyll
  module GravatarFilter
    def get_gravatar(input, size=75)
      "//www.gravatar.com/avatar/#{hash(input)}?s=#{size}"
    end

    private :hash

    def hash(email)
      email_address = email ? email.downcase.strip : ''
      Digest::MD5.hexdigest(email_address)
    end
  end
end

Liquid::Template.register_filter(Jekyll::GravatarFilter)