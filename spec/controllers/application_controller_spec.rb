require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      raise ActiveRecord::RecordNotFound
    end
  end

  describe 'handling ActiveRecord::RecordNotFound exceptions' do
    it 'responds with json format' do
      get :index, format: :json
      expect(response.body).to eq({ error: 'Record not found' }.to_json)
      expect(response).to have_http_status(:not_found)
    end

    it 'redirects to home page for html format' do
      get :index, format: :html
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Record not found')
    end
  end
end
