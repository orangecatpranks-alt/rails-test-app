module ApiSchemas
  module V1
    def self.pagination_metadata
      {
        type: :object,
        properties: {
          current_page: { type: :integer, example: 1 },
          total_pages:  { type: :integer, example: 3 },
          total_count:  { type: :integer, example: 50 },
          per_page:     { type: :integer, example: 10 }
        },
        required: [ 'current_page', 'total_pages', 'total_count', 'per_page' ]
      }
    end

    def self.movie
      {
        type: :object,
        properties: {
          id: { type: :integer, example: 1 },
          title: { type: :string, example: 'The Matrix' },
          description: { type: :string, example: 'A computer hacker...' },
          release_year: { type: :integer, example: 1999 },
          created_at: { type: :string, format: :datetime },
          updated_at: { type: :string, format: :datetime }
        },
        required: [ 'id', 'title' ]
      }
    end

    def self.movies_list
      {
        type: :array,
        items: movie
      }
    end

    def self.movies_index_response
      {
        type: :object,
        properties: {
          data: movies_list,
          meta: pagination_metadata
        },
        required: [ 'data', 'meta' ]
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
  end
end
