require 'rails_helper'

RSpec.describe "Api::V1::Movies", type: :request do
  let!(:movie) { create(:movie) }
  let!(:movie_with_nil) { create(:movie, description: nil, release_year: nil) }

  describe "GET /api/v1/movies" do
    before { get '/api/v1/movies' }

    it "returns a successful response" do
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      movies = json["data"]

      expect(movies.size).to eq(2)

      movies.each do |movie|
        expect(movie).to include('id', 'title', 'description', 'release_year')
        expect(movie['id']).to be_a(Integer)
        expect(movie['title']).to be_a(String)
        expect(movie['description']).to be_a(String).or be_nil
        expect(movie['release_year']).to be_a(Integer).or be_nil
      end
    end
  end
end
