BeatBot.Views.Searches ||= {}

class BeatBot.Views.Searches.NewView extends Backbone.View
  template: JST["templates/searches/new"]

  initialize: (options) ->
  
  events:
    'click .dev-create_playlist_button': 'create_playlist'

  create_playlist: (e) =>
    e.preventDefault()   
    $.ajax
      url: '/playlists'
      type: 'POST'
      dataType: 'json'
      data:
        playlist: @$('.dev-create_playlist_input').tokenInput("get")
      success: (data, textStatus, xhr) =>
      error: (data) ->

  setup_auto_suggest: () =>
    @$('.dev-create_playlist_input').tokenInput '/searches',
      theme: "mac"


  render: () =>
    @$el.html(@template())
    @setup_auto_suggest()