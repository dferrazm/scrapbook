describe 'Scrapnotes API V1' do
  let(:user) { create :user }
  let(:user_id) { user.id }
  let(:signed_user) { user }
  let(:note) { create :scrapnote, content: 'Hello world!', mood: build(:mood), user: user }
  let(:note_as_json) { note.attributes.slice("id", "content", "mood_id") }

  before { http_auth(signed_user) }

  shared_examples 'accessing_another_user_resources' do
    context 'when given user id does not match the signed in user' do
      let(:user_id) { 35435 }

      it 'returns unauthorized' do
        perform_request
        expect(response.status).to eq 403
      end
    end
  end

  describe 'index' do
    before { note }
    subject(:perform_request) { json_get "/api/v1/scrapnotes" }

    it 'returns all the scrapnotes' do
      notes_json = perform_request

      expect(response.status).to eq 200
      expect(notes_json).to eq [note_as_json]
    end
  end

  describe 'show' do
    let(:note_id) { note.id }
    subject(:perform_request) { json_get "/api/v1/scrapnotes/#{note_id}" }

    it 'returns the scrapnote' do
      note_json = perform_request

      expect(response.status).to eq 200
      expect(note_json).to eq note_as_json
    end

    context 'when record not found' do
      let(:note_id) { 12414 }

      it 'returns Not Found ' do
        perform_request
        expect(response.status).to eq 404
      end
    end
  end

  describe 'create' do
    subject(:perform_request) { json_post "/api/v1/users/#{user_id}/scrapnotes/", scrapnote: create_params }

    context 'valid scrapnote' do
      let(:note) { Scrapnote.last }
      let(:create_params) { { content: 'Hello world!' } }

      it 'creates the scrapnote and returns it' do
        expect do
          note_json = perform_request

          expect(response.status).to eq 200
          expect(note_json).to eq note_as_json
        end.to change(user.scrapnotes, :count).by(1)
      end

      include_examples 'accessing_another_user_resources'
    end

    context 'invalid scrapnote' do
      let(:create_params) { { content: '' } }

      it 'returns the error messages' do
        error_json = perform_request

        expect(response.status).to eq 400
        expect(error_json).to include('content' => ["can't be blank"])
      end
    end
  end

  shared_examples 'update the note' do
    let(:update_params) { { content: 'Happy!' } }

    it 'updates the note and returns it' do
      note_json = perform_request
      note.reload

      expect(response.status).to eq 200
      expect(note_json).to eq note_as_json
      expect(note.content).to eq 'Happy!'
    end
  end

  describe 'update' do
    let(:perform_request) { json_put "/api/v1/users/#{user_id}/scrapnotes/#{note.id}", scrapnote: update_params }

    context 'with valid parameters' do

      include_examples 'update the note'

      context 'when signed user is admin and trying to update another user note' do
        let(:signed_user) { create :admin_user }

        include_examples 'update the note'
      end

      include_examples 'accessing_another_user_resources'
    end

    context 'with invalid parameters' do
      let(:update_params) { { content: '' } }

      it 'returns the error messages' do
        error_json = perform_request

        expect(response.status).to eq 400
        expect(error_json).to include('content' => ["can't be blank"])
      end
    end
  end

  shared_examples 'destroy the note' do
    before { note }

    it 'destroys the note and returns it' do
      expect do
        note_json = perform_request

        expect(response.status).to eq 200
        expect(note_json).to eq note_as_json
      end.to change(user.scrapnotes, :count).by(-1)
    end
  end

  describe 'destroy' do
    let(:perform_request) { json_delete "/api/v1/users/#{user_id}/scrapnotes/#{note.id}" }

    include_examples 'destroy the note'

    context 'when signed user is admin and trying to destroy another user note' do
      let(:signed_user) { create :admin_user }

      include_examples 'destroy the note'
    end

    include_examples 'accessing_another_user_resources'
  end
end
