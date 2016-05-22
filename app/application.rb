require 'pry'
class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/) #request is .../items/...
      item_name = req.path.split(/items\//).last
      found_item = @@items.find {|i| i.name == item_name}
      if found_item
        resp.write found_item.price
      else
        resp.write "Item not found\n"
        resp.status = 400
      end
    else
      #return 404 error
      resp.write "Route not found\n"
      resp.status = 404
    end
    resp.finish
  end

end
