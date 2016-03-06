describe UserPolicy do
  let(:policy) { described_class.new(current_user, nil) }

  shared_examples 'only admin allowed' do
    context 'for admin' do
      let(:current_user) { build_stubbed :admin_user }
      it { is_expected.to be_truthy }
    end

    context 'for normal' do
      let(:current_user) { build_stubbed :user }
      it { is_expected.to be_falsy }
    end

    context 'for guest' do
      let(:current_user) { build_stubbed :guest_user }
      it { is_expected.to be_falsy }
    end
  end

  shared_examples 'everyone allowed' do
    context 'for admin' do
      let(:current_user) { build_stubbed :admin_user }
      it { is_expected.to be_truthy }
    end

    context 'for normal' do
      let(:current_user) { build_stubbed :user }
      it { is_expected.to be_truthy }
    end

    context 'for guest' do
      let(:current_user) { build_stubbed :guest_user }
      it { is_expected.to be_truthy }
    end
  end

  describe '#index?' do
    subject { policy.index? }
    include_examples 'everyone allowed'
  end

  describe '#show?' do
    subject { policy.show? }
    include_examples 'everyone allowed'
  end

  describe '#create?' do
    subject { policy.create? }
    include_examples 'only admin allowed'
  end

  describe '#update?' do
    subject { policy.update? }
    include_examples 'only admin allowed'
  end

  describe '#destroy?' do
    subject { policy.destroy? }
    include_examples 'only admin allowed'
  end
end
