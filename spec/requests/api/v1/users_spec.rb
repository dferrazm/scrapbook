describe 'Users API V1' do
  let(:user) { signed_user }
  let(:user_as_json) { user.attributes.slice("id", "username") }
  let(:signed_user) { create :user, username: 'jdoe' }

  before { http_auth(signed_user) }

  describe 'index' do
    it 'returns all the users' do
      users_json = json_get '/api/v1/users'

      expect(response.status).to eq 200
      expect(users_json).to eq [user_as_json]
    end
  end

  describe 'show' do
    it 'returns the user' do
      user_json = json_get "/api/v1/users/#{user.id}"

      expect(response.status).to eq 200
      expect(user_json).to eq user_as_json
    end

    it 'returns Not Found when record not found' do
      json_get '/api/v1/users/123'
      expect(response.status).to eq 404
    end
  end

  describe 'create' do
    context 'valid user' do
      let(:user) { User.last }

      it 'creates the user and returns it' do
        expect do
          user_json = json_post '/api/v1/users', user: { username: 'foobar', password: 'change123' }

          expect(response.status).to eq 200
          expect(user_json).to eq user_as_json
        end.to change(User, :count).by(1)
      end
    end

    context 'invalid user' do
      it 'returns the error messages' do
        error_json = json_post '/api/v1/users', user: { username: '' }

        expect(response.status).to eq 400
        expect(error_json).to include('username' => ["can't be blank"])
      end
    end
  end

  describe 'update' do
    context 'with valid parameters' do
      it 'updates the user and returns it' do
        user_json = json_put "/api/v1/users/#{user.id}", user: { username: 'foobar' }
        user.reload

        expect(response.status).to eq 200
        expect(user_json).to eq user_as_json
        expect(user.username).to eq 'foobar'
      end
    end

    context 'with invalid parameters' do
      it 'returns the error messages' do
        error_json = json_put "/api/v1/users/#{user.id}", user: { username: '' }

        expect(response.status).to eq 400
        expect(error_json).to include('username' => ["can't be blank"])
      end
    end
  end

  describe 'destroy' do
    it 'destroys the user and return it' do
      expect do
        user_json = json_delete "/api/v1/users/#{user.id}"

        expect(response.status).to eq 200
        expect(user_json).to eq user_as_json
      end.to change(User, :count).by(-1)
    end
  end
end
