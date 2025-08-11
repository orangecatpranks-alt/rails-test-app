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
              description: { type: :string, nullable: true, example: 'A computer hacker learns from mysterious rebels about the true nature of his reality.' },
              release_year: { type: :integer, nullable: true, example: 1999 }
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

    def self.movie_show_response
      {
        type: :object,
        properties: {
          data: { '$ref': '#/components/schemas/movie' }
        }
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

    def self.not_found_error
      {
        type: :object,
        properties: {
          error: {
            type: :object,
            properties: {
              message: { type: :string, example: 'Movie not found' }
            },
            required: [ 'message' ]
          }
        },
        required: [ 'error' ]
      }
    end
  end
end
