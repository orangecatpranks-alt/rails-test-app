module ApiSchemas
  module V1
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

    def self.error_response
      {
        type: :object,
        properties: {
          error: { type: :string },
          message: { type: :string }
        }
      }
    end
  end
end
