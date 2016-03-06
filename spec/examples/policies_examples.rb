module PoliciesExamples
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
end
