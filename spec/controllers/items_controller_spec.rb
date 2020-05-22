require 'rails_helper'
require_relative '../support/devise'

RSpec.describe ItemsController, type: :controller do
  describe 'Login' do
    let(:category)       { create(:category) }
    let(:create_item)    { create(:item, category_id: category.id ) }
    let(:valid_params)   {{ title: 'Item title', price: 10, date: Date.today, category_id: category.id }}
    let(:invalid_params) {{ title: '', price: 10, date: Date.today, category_id: category.id }}

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
          get :show, params: { id: create_item.id }
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
          get :edit, params: { id: create_item.id }
          expect(response).to be_successful
        end
      end

      describe 'GET #edit' do
        it 'returns a success response' do
          get :edit, params: { id: create_item.id }
          expect(response).to be_successful
        end
      end

      describe "POST #create" do
        context "with valid params" do
          it "creates a new Item" do
            expect {
              post :create, params: { item: valid_params }
            }.to change(Item, :count).by(1)
          end
    
          it "redirects to the created item" do
            post :create, params: { item: valid_params }
            expect(response).to redirect_to(Item.last)
          end
        end
    
        context "with invalid params" do
          it "returns a success response (to display the 'new' template)" do
            post :create, params: { item: invalid_params }
            expect(response).to be_successful
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:new_params) {{ title: 'New item title' }}
    
          it "updates the requested item" do
            item_title = create_item.title
            put :update, params: { id: create_item.id, item: new_params }
            create_item.reload
            expect(item_title).not_to eq(new_params[:title])
          end
    
          it "redirects to the item" do
            put :update, params: { id: create_item.id, item: valid_params }
            expect(response).to redirect_to(create_item)
          end
        end
    
        context "with invalid params" do
          it "returns a success response (to display the 'edit' template)" do
            put :update, params: { id: create_item.id, item: invalid_params }
            expect(response).to be_successful
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested item" do
          item = create_item
          expect {
            delete :destroy, params: {id: item.id}
          }.to change(Item, :count).by(-1)
        end
    
        it "redirects to the orders list" do
          item = create_item
          delete :destroy, params: {id: item.id}
          expect(response).to redirect_to(items_url)
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
          get :show, params: { id: create_item.id }
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
          get :edit, params: { id: create_item.id }
          expect(response).to be_unauthorized
        end
      end

      describe 'GET #edit' do
        it 'returns a unauthorized response' do
          get :edit, params: { id: create_item.id }
          expect(response).to be_unauthorized
        end
      end

      describe "POST #create" do
        context "with valid params" do
          it "creates a new Item" do
            post :create, params: { item: valid_params }
            expect(response).to be_unauthorized
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:new_params) {{ title: 'New item title' }}
    
          it "updates the requested item" do
            item_title = create_item.title
            put :update, params: { id: create_item.id, item: new_params }
            create_item.reload
            expect(item_title).not_to eq(new_params[:title])
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested item" do
          item = create_item
          expect {
            delete :destroy, params: { id: item.id }
          }.to change(Item, :count).by(0)
        end
      end
    end
  end
end