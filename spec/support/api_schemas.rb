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
