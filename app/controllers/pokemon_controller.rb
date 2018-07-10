class PokemonController < ApplicationController
  def show
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(res.body)
    name = body["name"]
    id = body["id"]
    types = types(body)

    gif_res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}&rating=g")
    gif_body = JSON.parse(gif_res.body)
    gif = random_gif(gif_body).sample

    render json: { id: id, name: name, types: types, gif: gif }
  end


  def types(body)
    body["types"].map do |hash|
      hash["type"]["name"]
    end
  end

  def random_gif(body)
    body["data"].map do |hash|
       hash["url"]
    end
  end



end
