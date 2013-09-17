BeatBot.Views.Searches ||= {}

class BeatBot.Views.Searches.NewView extends Backbone.View
  template: JST["templates/searches/new"]

  initialize: (options) ->
    @current_url = ""
    @songs_array = []
  
  events:
    'click .dev-create_playlist_button': 'create_playlist'
    # 'click .dev-next': 'next_video'
    # 'click .dev-previous': 'previous_video'

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
      # onRemove: (item) =>
      #   songs_array = @$('.dev-create_playlist_input').tokenInput("get")
      #   if songs_array.length == 0 or songs_array.length == 1
      #     @$(".dev-previous").hide()
      #     @$(".dev-next").hide()

  go_to_next_video: (newState) =>
    if newState == 0
      songs_array = @$('.dev-create_playlist_input').tokenInput("get")
      # current_video = @find_current_video(songs_array)
      # current_video_id = current_video.id
      # current_index = current_video.index
      #@disable_enable_buttons(current_index, songs_array.length)

      if songs_array.length > 0
        @load_next_video()
      else
        alert("please add songs to continue")

  find_current_video: (songs_array) =>
    id_map = _.map songs_array, (item) ->
            item.id
    @current_url = ytplayer.getVideoUrl()
    current_video_id = @current_url.split("v=").pop()
    current_index = id_map.indexOf(current_video_id)
    {id: current_video_id, index: current_index}

  load_next_video: () =>
    songs_array = @$('.dev-create_playlist_input').tokenInput("get")
    current_video = @find_current_video(songs_array)
    current_video_id = current_video.id
    current_index = current_video.index
    #@disable_enable_buttons(current_index, songs_array.length)
    @$("#delete_song_"+current_video_id).show().parent().removeClass("white_li")
    @$("#delete_song_"+songs_array[current_index+1].id).hide().parent().addClass("white_li")
    ytplayer.loadVideoById(videoId: songs_array[current_index+1].id)

  # load_previous_video: () =>
  #   songs_array = @$('.dev-create_playlist_input').tokenInput("get")
  #   current_video = @find_current_video(songs_array)
  #   current_video_id = current_video.id
  #   current_index = current_video.index
  #   @disable_enable_buttons(current_index, songs_array.length)
  #   @$("#delete_song_"+current_video_id).show().parent().removeClass("white_li")
  #   @$("#delete_song_"+songs_array[current_index-1].id).hide().parent().addClass("white_li")
  #   ytplayer.loadVideoById(videoId: songs_array[current_index-1].id)

  # next_video: (e) =>
  #   e.preventDefault()
  #   @load_next_video()

  # previous_video: (e) =>
  #   e.preventDefault()
  #   @load_previous_video()

  # disable_enable_buttons: (current_index, songs_array_length) =>
  #   if current_index+1 > 0 and current_index+1 < songs_array_length and current_index+1 != songs_array_length-1
  #     @$(".dev-previous, .dev-next").show()
  #   else if current_index+1 == songs_array_length-1
  #     @$(".dev-next").hide()
  #     @$(".dev-previous").show()
  #   else if current_index == 0 and songs_array_length < 1
  #     @$(".dev-previous, .dev-next").hide()
  #   else if (current_index == 0 or current_index+1 == 0) and songs_array_length > 1
  #     @$(".dev-next").show()
  #     @$(".dev-previous").hide()

  render: () =>
    @$el.html(@template())
    @$(".dev-previous, .dev-next").hide()
    @setup_auto_suggest()