describe 'Moods API V1' do
  let(:mood) { create :mood, description: 'Sad' }
  let(:mood_as_json) { mood.attributes.slice("id", "description") }

  describe 'index' do
    before { mood }

    it 'returns all the moods' do
      moods_json = json_get '/api/v1/moods'

      expect(response.status).to eq 200
      expect(moods_json).to eq [mood_as_json]
    end
  end

  describe 'show' do
    it 'returns the mood' do
      mood_json = json_get "/api/v1/moods/#{mood.id}"

      expect(response.status).to eq 200
      expect(mood_json).to eq mood_as_json
    end

    it 'returns Not Found when record not found' do
      get '/api/v1/moods/123'
      expect(response.status).to eq 404
    end
  end

  describe 'create' do
    context 'valid mood' do
      let(:mood) { Mood.last }

      it 'creates the mood and returns it' do
        expect do
          mood_json = json_post '/api/v1/moods', mood: { description: 'Anxious' }

          expect(response.status).to eq 200
          expect(mood_json).to eq mood_as_json
        end.to change(Mood, :count).by(1)
      end
    end

    context 'invalid mood' do
      it 'returns the error messages' do
        error_json = json_post '/api/v1/moods', mood: { description: '' }

        expect(response.status).to eq 400
        expect(error_json).to include('description' => ["can't be blank"])
      end
    end
  end

  describe 'update' do
    context 'with valid parameters' do
      it 'creates the mood and returns it' do
        mood_json = json_put "/api/v1/moods/#{mood.id}", mood: { description: 'Happy' }
        mood.reload

        expect(response.status).to eq 200
        expect(mood_json).to eq mood_as_json
        expect(mood.description).to eq 'Happy'
      end
    end

    context 'with invalid parameters' do
      it 'returns the error messages' do
        error_json = json_put "/api/v1/moods/#{mood.id}", mood: { description: '' }

        expect(response.status).to eq 400
        expect(error_json).to include('description' => ["can't be blank"])
      end
    end
  end

  describe 'destroy' do
    before { mood }

    it 'destroys the mood and return it' do
      expect do
        mood_json = json_delete "/api/v1/moods/#{mood.id}"

        expect(response.status).to eq 200
        expect(mood_json).to eq mood_as_json
      end.to change(Mood, :count).by(-1)
    end
  end
end
