class SearchSuggestions
  def initialize(app)
    @app = app
  end

  def call(env)
    if env["PATH_INFO"] == "/searches" and env["REQUEST_METHOD"].downcase == "get"
      request = Rack::Request.new(env)
      terms = Search.get_suggestions(request.params["q"])
      [200, {"Content-Type" => "application/json"}, [terms.to_json]]
    else
      @app.call(env)
    end
  end
end