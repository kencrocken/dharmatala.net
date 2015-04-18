---
---
scrollToTop = ->
  $('a[href=\'#top\']').on 'click', ->
    $('html, body').animate { scrollTop: 0 }, 'slow'
    false
  return

scrollToTop()

$('a[href*=#]:not(a[href=#top])').click (e) ->
  $('html, body').animate { scrollTop: $($.attr(this, 'href')).offset().top }, 500
  e.preventDefault()
  return

###*
# name jQuery Stick 'em
# author Trevor Davis
# version 1.4.1
#
#   $('.container').stickem({
#       item: '.stickem',
#       container: '.stickem-container',
#       stickClass: 'stickit',
#       endStickClass: 'stickit-end',
#       offset: 0,
#       onStick: null,
#       onUnstick: null
#   });
###

(($, window, document) ->

  Stickem = (elem, options) ->
    @elem = elem
    @$elem = $(elem)
    @options = options
    @metadata = @$elem.data('stickem-options')
    @$win = $(window)
    return

  Stickem.prototype =
    defaults:
      item: '.stickem'
      container: '.stickem-container'
      stickClass: 'stickit'
      endStickClass: 'stickit-end'
      offset: 0
      start: 0
      onStick: null
      onUnstick: null
    init: ->
      _self = this
      #Merge options
      _self.config = $.extend({}, _self.defaults, _self.options, _self.metadata)
      _self.setWindowHeight()
      _self.getItems()
      _self.bindEvents()
      _self
    bindEvents: ->
      _self = this
      _self.$win.on 'scroll.stickem', $.proxy(_self.handleScroll, _self)
      _self.$win.on 'resize.stickem', $.proxy(_self.handleResize, _self)
      return
    destroy: ->
      _self = this
      _self.$win.off 'scroll.stickem'
      _self.$win.off 'resize.stickem'
      return
    getItem: (index, element) ->
      _self = this
      $this = $(element)
      item = 
        $elem: $this
        elemHeight: $this.height()
        $container: $this.parents(_self.config.container)
        isStuck: false
      #If the element is smaller than the window
      if _self.windowHeight > item.elemHeight
        item.containerHeight = item.$container.outerHeight()
        item.containerInner =
          border:
            bottom: parseInt(item.$container.css('border-bottom'), 10) or 0
            top: parseInt(item.$container.css('border-top'), 10) or 0
          padding:
            bottom: parseInt(item.$container.css('padding-bottom'), 10) or 0
            top: parseInt(item.$container.css('padding-top'), 10) or 0
        item.containerInnerHeight = item.$container.height()
        item.containerStart = item.$container.offset().top - _self.config.offset + _self.config.start + item.containerInner.padding.top + item.containerInner.border.top
        item.scrollFinish = item.containerStart - _self.config.start + item.containerInnerHeight - item.elemHeight
        #If the element is smaller than the container
        if item.containerInnerHeight > item.elemHeight
          _self.items.push item
      else
        item.$elem.removeClass _self.config.stickClass + ' ' + _self.config.endStickClass
      return
    getItems: ->
      _self = this
      _self.items = []
      _self.$elem.find(_self.config.item).each $.proxy(_self.getItem, _self)
      return
    handleResize: ->
      _self = this
      _self.getItems()
      _self.setWindowHeight()
      return
    handleScroll: ->
      _self = this
      if _self.items.length > 0
        pos = _self.$win.scrollTop()
        i = 0
        len = _self.items.length
        while i < len
          item = _self.items[i]
          #If it's stuck, and we need to unstick it, or if the page loads below it
          if item.isStuck and (pos < item.containerStart or pos > item.scrollFinish) or pos > item.scrollFinish
            item.$elem.removeClass _self.config.stickClass
            #only at the bottom
            if pos > item.scrollFinish
              item.$elem.addClass _self.config.endStickClass
            item.isStuck = false
            #if supplied fire the onUnstick callback
            if _self.config.onUnstick
              _self.config.onUnstick item
            #If we need to stick it
          else if item.isStuck == false and pos > item.containerStart and pos < item.scrollFinish
            item.$elem.removeClass(_self.config.endStickClass).addClass _self.config.stickClass
            item.isStuck = true
            #if supplied fire the onStick callback
            if _self.config.onStick
              _self.config.onStick item
          i++
      return
    setWindowHeight: ->
      _self = this
      _self.windowHeight = _self.$win.height() - _self.config.offset
      return
  Stickem.defaults = Stickem::defaults

  $.fn.stickem = (options) ->
    #Create a destroy method so that you can kill it and call it again.

    @destroy = ->
      @each ->
        new Stickem(this, options).destroy()
        return
      return

    @each ->
      new Stickem(this, options).init()
      return

  return
) jQuery, window, document
