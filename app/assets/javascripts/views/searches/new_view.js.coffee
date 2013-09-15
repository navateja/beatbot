BeatBot.Views.Searches ||= {}

class BeatBot.Views.Searches.NewView extends Backbone.View
  template: JST["templates/searches/new"]

  initialize: (options) ->
  
  events:
    'click .dev-create_playlist_button': 'create_playlist'

  create_playlist: (e) =>
    e.preventDefault()
    songs_list = @$(".dev-create_playlist_input").val()
    $.ajax
      url: '/playlists?playlist='+songs_list
      type: 'POST'
      success: (data, textStatus, xhr) =>
      error: (data) ->

  setup_auto_suggest: () =>
    @$('.dev-create_playlist_input').tokenInput '/searches',
      theme: "mac"


  render: () =>
    @$el.html(@template())
    @setup_auto_suggest()