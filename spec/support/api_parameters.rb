module ApiParameters
  module V1
    def self.pagination_params
      [
        {
          name: :page,
          in: :query,
          type: :integer,
          description: 'Page number (default: 1)',
          required: false,
          example: 1
        },
        {
          name: :per_page,
          in: :query,
          type: :integer,
          description: "Items per page (default: #{Kaminari.config.default_per_page}, max: #{Kaminari.config.max_per_page})",
          required: false,
          example: Kaminari.config.default_per_page
        }
      ]
    end
  end
end
