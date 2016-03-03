describe Scrapnote do
  it 'has a valid factory' do
    expect(build :scrapnote).to be_valid
  end

  describe 'validations' do
    it 'is invalid without a user owning it' do
      expect(build :scrapnote, user: nil).to_not be_valid
    end

    it 'is invalid without a content' do
      expect(build :scrapnote, content: nil).to_not be_valid
    end
  end
end
