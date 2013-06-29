require(['app', 'jquery', 'bootstrap'], (app, $) ->
    'use strict'
    console.log 'ajax'
    $('.btn-song').on 'click', ->

      window.global = {}
      window.req = $.ajax
        url: './scripts/teen.json'

      window.req.done (d) ->
        console.log d
        $(d.objects).each ->
          console.log @body_chords_html
          $('.song-chords').html(@body_chords_html)

)
