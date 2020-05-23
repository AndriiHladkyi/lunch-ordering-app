module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @admin = FactoryBot.create(:user)
      @user = FactoryBot.create(:user)
      sign_in @admin
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @admin = FactoryBot.create(:user)
      @user = FactoryBot.create(:user)
      sign_in @user
    end
  end

  def authenticated_header(user, password)
    response = AuthenticateUser.call(user, password)
    { "Authorization" => "Bearer #{response.result}" }
  end
end