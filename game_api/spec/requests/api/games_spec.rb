require 'rails_helper'

RSpec.describe "Games API", type: :request do
  describe "POST /api/games" do
    context "when the request is valid" do
      before { post api_games_path }

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end

      it "responses with game model" do
        game = Game.last # May not works with parallel tests, depends on transaction configuration, but it's ok for now
        expect(json_response).to eq(game.as_json)
      end
    end

    context "when the request is invalid" do
      # Not part of test assessment
    end
  end

  describe "POST /api/games/:id" do
    let!(:game) { FactoryBot.create(:game) }

    context "when the request is valid" do
      before { get api_game_path(game.id) }

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request game with wrong ID" do
      before { get api_game_path('wrongID') }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found errro message" do
        expect(json_response).to eq({
          "error"=>{"message"=>"Record not found", "type"=>"RecordNotFound"}
        })
      end
    end
  end

  # Helper method to parse the response body to JSON
  def json_response
    JSON.parse(response.body)
  end
end