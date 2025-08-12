RSpec.configure do |config|
  config.after(type: :request, rswag: true) do |example|
    if response.body.to_s.strip.present?
      example.metadata[:response][:content] = {
        'application/json' => {
          example: JSON.parse(response.body, symbolize_names: true)
        }
      }
    end
  end
end
