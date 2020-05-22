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

  def create_categories
    (0..2).each do
      FactoryBot.create(:category)
    end
  end

  def create_items
    Category.all.map do |category|
      FactoryBot.create(:item, category_id: category.id)
    end
    FactoryBot.create(:item, category_id: Category.first.id)

    Item.all.each do |item|
      instance_variable_set("@item#{item.id}", item)
    end
  end
end