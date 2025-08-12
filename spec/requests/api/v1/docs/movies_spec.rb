require 'swagger_helper'

RSpec.describe 'api/v1/movies', type: :request do
  path '/api/v1/movies' do
    get 'List movies' do
      tags 'Movies'
      description 'Retrieve all movies'
      produces 'application/json'

      parameter '$ref': '#/components/parameters/page'
      parameter '$ref': '#/components/parameters/per_page'

      response 200, 'OK' do
        schema ApiSchemas::V1.movies_index_response
        let(:page) { 1 }
        let(:per_page) { 2 }
        before { create_list(:movie, 5) }
        run_test!
      end

      response 500, 'Internal server error' do
        schema ApiSchemas::V1.internal_server_error
        it 'documents 500 error only' do
          # no request — used only for OpenAPI docs
        end
      end
    end

    post 'Create a movie' do
      tags 'Movies'
      description 'Create a new movie'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :movie, in: :body, required: true, schema: ApiSchemas::V1.movie_create_request

      response 201, 'Created' do
        schema ApiSchemas::V1.movie_create_response
        let(:movie) { { movie: attributes_for(:movie) } }
        run_test!
      end

      response 422, 'Invalid request' do
        schema ApiSchemas::V1.unprocessable_entity_response
        let(:movie) { { movie: { title: '', description: 'Invalid movie without title' } } }
        run_test!
      end
    end
  end

  path '/api/v1/movies/{id}' do
    get 'Get movie by ID' do
      tags 'Movies'
      description 'Retrieve a specific movie by ID'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, description: 'Movie ID'

      response 200, 'Movie found' do
        schema ApiSchemas::V1.movie_show_response
        let(:movie) { create(:movie) }
        let(:id) { movie.id }
        run_test!
      end

      response 404, 'Movie not found' do
        schema ApiSchemas::V1.not_found_error
        let(:id) { 99999 }
        run_test!
      end
    end

    delete 'Delete movie by ID' do
      tags 'Movies'
      description 'Delete a specific movie by ID'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, description: 'Movie ID'

      response 204, 'Movie deleted successfully' do
        let(:movie) { create(:movie) }
        let(:id) { movie.id }
        run_test!
      end

      response 404, 'Movie not found' do
        schema ApiSchemas::V1.not_found_error
        let(:id) { 99999 }
        run_test!
      end
    end
  end
  #   patch('update movie') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end

  #   put('update movie') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
end
