describe User do
  it 'has a valid factory' do
    expect(build :user).to be_valid
  end

  describe 'validations' do
    it 'is invalid without a username' do
      expect(build :user, username: nil).to_not be_valid
    end

    it 'is invalid with a taken username' do
      create :user, username: 'john'
      expect(build :user, username: 'john').to_not be_valid
    end

    it 'is invalid without a password' do
      expect(build :user, password: nil).to_not be_valid
    end

    it 'is valid only with a valid role' do
      Role::LIST.each do |role|
        expect(build :user, role: role).to be_valid
      end

      expect(build :user, role: 'invalid_role').to_not be_valid
    end
  end
end
