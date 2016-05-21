require 'pry'
class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/) #request is .../items/...
      item_name = req.path.split(/items\//).last

      if item_found?(item_name)
        resp.write "#{find_item_by_name(item_name).price}\n" #return price of that item
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

  def item_found?(item_name)
    @@items.each do |i|
      return true if i.name == item_name
    end
    return false
  end

  def find_item_by_name(item_name)
    @@items.each do |i|
      return i if i.name == item_name
    end
  end

end
