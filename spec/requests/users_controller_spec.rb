RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    it 'renders the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'returns a 200 OK status' do
      get '/users'
      expect(response).to have_http_status(:ok)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('Here is a list of users!')
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get '/users/123'
      expect(response).to render_template(:show)
    end

    it 'returns a 200 OK status' do
      get '/users/123'
      expect(response).to have_http_status(:ok)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users/123'
      expect(response.body).to include('Here is a list of posts for a specific user')
    end
  end
end
