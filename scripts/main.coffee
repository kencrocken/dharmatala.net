---
---
$('a[href*=#]').click (e) ->
  $('html, body').animate { scrollTop: $($.attr(this, 'href')).offset().top }, 500
  e.preventDefault()
  return