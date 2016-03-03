describe 'Users API V1' do
  let(:user) { create :user, name: 'John Doe' }
  let(:user_as_json) { user.attributes.slice("id", "name") }

  describe 'index' do
    before { user }

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
      get '/api/v1/users/123'
      expect(response.status).to eq 404
    end
  end

  describe 'create' do
    context 'valid user' do
      let(:user) { User.last }

      it 'creates the user and returns it' do
        expect do
          user_json = json_post '/api/v1/users', user: { name: 'John Doe' }

          expect(response.status).to eq 200
          expect(user_json).to eq user_as_json
        end.to change(User, :count).by(1)
      end
    end

    context 'invalid user' do
      it 'returns the error messages' do
        error_json = json_post '/api/v1/users', user: { name: '' }

        expect(response.status).to eq 400
        expect(error_json).to include('name' => ["can't be blank"])
      end
    end
  end

  describe 'update' do
    context 'with valid parameters' do
      it 'creates the user and returns it' do
        user_json = json_put "/api/v1/users/#{user.id}", user: { name: 'Batman' }
        user.reload

        expect(response.status).to eq 200
        expect(user_json).to eq user_as_json
        expect(user.name).to eq 'Batman'
      end
    end

    context 'with invalid parameters' do
      it 'returns the error messages' do
        error_json = json_put "/api/v1/users/#{user.id}", user: { name: '' }

        expect(response.status).to eq 400
        expect(error_json).to include('name' => ["can't be blank"])
      end
    end
  end

  describe 'destroy' do
    before { user }

    it 'destroys the user and return it' do
      expect do
        user_json = json_delete "/api/v1/users/#{user.id}"

        expect(response.status).to eq 200
        expect(user_json).to eq user_as_json
      end.to change(User, :count).by(-1)
    end
  end
end
