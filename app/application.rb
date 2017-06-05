class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      #dynamic URL for item/<item_name>
      item_name = req.path.split("/items/").last
      #if item is a match to one in the list then display it's price
        if item = @@items.find{|x| x.name == item_name}
            resp.write item.price
      #if they have a URL with an item that is not on the list then serve a 400 error
        else
            resp.write "Item not found. Bad request"
            resp.status = 400
        end
    #if it's any other URL then serve a 404 error
    else
      resp.write "Route not found"
      resp.status = 404

    end

    resp.finish
  end


end
