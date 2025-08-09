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

      parameter name: :movie, in: :body, schema: ApiSchemas::V1.movie_create_request

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

  # path '/api/v1/movies/{id}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'

  #   get('show movie') do
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

  #   delete('delete movie') do
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
  # end
end
