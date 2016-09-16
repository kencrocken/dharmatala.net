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