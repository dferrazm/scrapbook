describe 'Scrapnotes API V1' do
  let(:user) { create :user }
  let(:note) { create :scrapnote, content: 'Hello world!', mood: build(:mood), user: user }
  let(:another_user_note) { create :scrapnote }
  let(:note_as_json) { note.attributes.slice("id", "content", "mood_id") }

  before { http_auth(user) }

  describe 'index' do
    before { note; another_user_note }

    it 'returns all the scarpnotes' do
      notes_json = json_get "/api/v1/users/#{user.id}/scrapnotes"

      expect(response.status).to eq 200
      expect(notes_json).to eq [note_as_json]
    end
  end

  describe 'show' do
    it 'returns the scrapnote' do
      note_json = json_get "/api/v1/users/#{user.id}/scrapnotes/#{note.id}"

      expect(response.status).to eq 200
      expect(note_json).to eq note_as_json
    end

    it 'returns Not Found when record not found' do
      json_get "/api/v1/users/#{user.id}/scrapnotes/#{another_user_note.id}"
      expect(response.status).to eq 404
    end
  end

  describe 'create' do
    context 'valid scrapnote' do
      let(:note) { Scrapnote.last }

      it 'creates the scrapnote and returns it' do
        expect do
          note_json = json_post "/api/v1/users/#{user.id}/scrapnotes/", scrapnote: { content: 'Hello world!' }

          expect(response.status).to eq 200
          expect(note_json).to eq note_as_json
        end.to change(user.scrapnotes, :count).by(1)
      end
    end

    context 'invalid scrapnote' do
      it 'returns the error messages' do
        error_json = json_post "/api/v1/users/#{user.id}/scrapnotes/", scrapnote: { content: '' }

        expect(response.status).to eq 400
        expect(error_json).to include('content' => ["can't be blank"])
      end
    end
  end

  describe 'update' do
    context 'with valid parameters' do
      it 'updates the note and returns it' do
        note_json = json_put "/api/v1/users/#{user.id}/scrapnotes/#{note.id}", scrapnote: { content: 'Happy!' }
        note.reload

        expect(response.status).to eq 200
        expect(note_json).to eq note_as_json
        expect(note.content).to eq 'Happy!'
      end
    end

    context 'with invalid parameters' do
      it 'returns the error messages' do
        error_json = json_put "/api/v1/users/#{user.id}/scrapnotes/#{note.id}", scrapnote: { content: '' }

        expect(response.status).to eq 400
        expect(error_json).to include('content' => ["can't be blank"])
      end
    end
  end

  describe 'destroy' do
    before { note }

    it 'destroys the note and returns it' do
      expect do
        note_json = json_delete "/api/v1/users/#{user.id}/scrapnotes/#{note.id}"

        expect(response.status).to eq 200
        expect(note_json).to eq note_as_json
      end.to change(user.scrapnotes, :count).by(-1)
    end
  end
end
