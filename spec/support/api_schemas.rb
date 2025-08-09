module ApiSchemas
  module V1
    def self.movies_index_response
      {
        type: :object,
        properties: {
          data: {
            type: :array,
            items: { '$ref': '#/components/schemas/movie' }
          },
          meta: { '$ref': '#/components/schemas/pagination_metadata' }
        },
        required: [ 'data', 'meta' ]
      }
    end

    def self.movie_create_request
      {
        type: :object,
        properties: {
          movie: {
            type: :object,
            properties: {
              title: { type: :string, example: 'The Matrix' },
              description: { type: :string, example: 'A computer hacker learns from mysterious rebels about the true nature of his reality.' },
              release_year: { type: :integer, example: 1999 }
            },
            required: [ 'title' ]
          }
        },
        required: [ 'movie' ]
      }
    end

    def self.movie_create_response
      {
        type: :object,
        properties: {
          data: { '$ref': '#/components/schemas/movie' }
        },
        required: [ 'data' ]
      }
    end

    def self.internal_server_error
      {
        type: :object,
        properties: {
          status: {
            type: :integer,
            example: 500,
            description: 'HTTP status code'
          },
          error: {
            type: :string,
            example: 'Internal Server Error',
            description: 'Error message'
          }
        },
        required: [ 'status', 'error' ]
      }
    end

    def self.unprocessable_entity_response
      {
        type: :object,
        properties: {
          errors: {
            type: :array,
            items: { type: :string, example: "Title can't be blank" }
          }
        },
        required: [ 'errors' ]
      }
    end
  end
end
