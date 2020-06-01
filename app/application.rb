require 'pry'

class Application
  @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      # item = Item.find_by_name(req.path.split("/")[1])
      new_item = req.path.split("/").last
      new_item = @@items.find { |item| item.name == new_item }
      if new_item.nil?
        #binding.pry
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write new_item.price
        resp.status = 200
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end