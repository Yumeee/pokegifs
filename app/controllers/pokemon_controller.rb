class PokemonController < ApplicationController
  def show
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(res.body)
    name = body["name"]
    id = body["id"]
    types = types(body)

    render json: { id: id, name: name, types: types}
  end


  def types(body)
    body["types"].map do |hash|
      hash["type"]["name"]
    end
  end


end
