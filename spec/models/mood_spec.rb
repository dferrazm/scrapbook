describe Mood do
  it 'has a valid factory' do
    expect(build :mood).to be_valid
  end

  describe 'validations' do
    it 'is invalid without a description' do
      expect(build :mood, description: nil).to_not be_valid
    end
  end
end
