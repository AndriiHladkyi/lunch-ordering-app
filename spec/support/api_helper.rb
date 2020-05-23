module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def authenticated_header(user, password)
    response = AuthenticateUser.call(user, password)
    { "Authorization" => "Bearer #{response.result}" }
  end
end

RSpec.configure do |config|
  config.include ApiHelper, :type=>:api
end