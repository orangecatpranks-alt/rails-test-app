RSpec.configure do |config|
  config.after(type: :request, rswag: true) do |example|
    example.metadata[:response][:content] = {
      'application/json' => {
        example: JSON.parse(response.body, symbolize_names: true)
      }
    }
  end
end
