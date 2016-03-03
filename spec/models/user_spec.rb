describe User do
  it 'has a valid factory' do
    expect(build :user).to be_valid
  end

  describe 'validations' do
    it 'is invalid without a name' do
      expect(build :user, name: nil).to_not be_valid
    end
  end
end
