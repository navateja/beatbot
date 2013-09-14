class BeatBot.Models.Search extends Backbone.Model
  paramRoot: 'search'
  urlRoot: '/searches'
  idAttribute: '_id'

  defaults: =>
    songs: []
