require 'rails_helper'
require_relative '../support/devise'

RSpec.describe CategoriesController, type: :controller do
  describe 'Login' do
    let(:category) { create(:category) }
    let(:valid_params)    {{ name: 'Category' }}
    let(:invalid_params)  {{ name: '' }}

    describe 'as admin' do
      login_admin

      describe 'GET #index' do
        it 'returns a success response' do
          get :index
          expect(response).to be_successful
        end
      end

      describe 'GET #show' do
        it 'returns a success response' do
          get :show, params: { id: category.id }
          expect(response).to be_successful
        end
      end

      describe 'GET #new' do
        it 'returns a success response' do
          get :new, params: valid_params
          expect(response).to be_successful
        end
      end

      describe 'GET #edit' do
        it 'returns a success response' do
          get :edit, params: { id: category.id }
          expect(response).to be_successful
        end
      end

      describe 'GET #edit' do
        it 'returns a success response' do
          get :edit, params: { id: category.id }
          expect(response).to be_successful
        end
      end

      describe "POST #create" do
        context "with valid params" do
          it "creates a new Item" do
            expect {
              post :create, params: { category: valid_params }
            }.to change(Category, :count).by(1)
          end
    
          it "redirects to the created item" do
            post :create, params: { category: valid_params }
            expect(response).to redirect_to(Category.last)
          end
        end
    
        context "with invalid params" do
          it "returns a success response (to display the 'new' template)" do
            post :create, params: { category: invalid_params }
            expect(response).to be_successful
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:new_params) {{ name: 'New category name' }}
    
          it "updates the requested category" do
            category_name = category.name
            put :update, params: { id: category.id, category: new_params }
            category.reload
            expect(category_name).not_to eq(new_params[:name])
          end
    
          it "redirects to the category" do
            put :update, params: { id: category.id, category: valid_params }
            expect(response).to redirect_to(category)
          end
        end
    
        context "with invalid params" do
          it "returns a success response (to display the 'edit' template)" do
            put :update, params: { id: category.id, category: invalid_params }
            expect(response).to be_successful
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested category" do
          new_category = category
          expect {
            delete :destroy, params: {id: new_category.id}
          }.to change(Category, :count).by(-1)
        end
    
        it "redirects to the orders list" do
          new_category = category
          delete :destroy, params: {id: new_category.id}
          expect(response).to redirect_to(categories_url)
        end
      end
    end

    describe 'as user' do
      login_user

      describe 'GET #index' do
        it 'returns a unauthorized response' do
          get :index
          expect(response).to be_unauthorized
        end
      end

      describe 'GET #show' do
        it 'returns a unauthorized response' do
          get :show, params: { id: category.id }
          expect(response).to be_unauthorized
        end
      end

      describe 'GET #new' do
        it 'returns a unauthorized response' do
          get :new, params: valid_params
          expect(response).to be_unauthorized
        end
      end

      describe 'GET #edit' do
        it 'returns a unauthorized response' do
          get :edit, params: { id: category.id }
          expect(response).to be_unauthorized
        end
      end

      describe 'GET #edit' do
        it 'returns a unauthorized response' do
          get :edit, params: { id: category.id }
          expect(response).to be_unauthorized
        end
      end

      describe "POST #create" do
        context "with valid params" do
          it "creates a new category" do
            post :create, params: { category: valid_params }
            expect(response).to be_unauthorized
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:new_params) {{ name: 'New category name' }}
    
          it "updates the requested category" do
            category_name = category.name
            put :update, params: { id: category.id, category: new_params }
            category.reload
            expect(category_name).not_to eq(new_params[:name])
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested category" do
          new_category = category
          expect {
            delete :destroy, params: { id: category.id }
          }.to change(Category, :count).by(0)
        end
      end
    end
  end
end