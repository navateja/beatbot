# Always set window.render_through_bb = true at the end of a route for which the content is initially rendered by the server.

class BeatBot.Routers.ApplicationRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    'text_to_playlist': 'text_to_playlist'

  text_to_playlist: () =>
    @view = new BeatBot.Views.Searches.NewView()
    $("#beatbot_content").html(@view.el)
    @view.render()
