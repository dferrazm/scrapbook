require_relative '../examples/policies_examples'

describe ScrapnotePolicy do
  let(:policy) { described_class.new(current_user, target) }
  let(:target) { nil }

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
      it { is_expected.to be_falsy }
    end
  end

  describe '#update?' do
    subject { policy.update? }

    context 'for admin' do
      let(:current_user) { build_stubbed :admin_user }
      it { is_expected.to be_truthy }
    end

    context 'for normal' do
      let(:current_user) { create :user }

      context 'owning the target scrapnote' do
        let(:target) { create :scrapnote, user: current_user }
        it { is_expected.to be_truthy }
      end

      context 'not owning the target scrapnote' do
        let(:target) { create :scrapnote }
        it { is_expected.to be_falsy }
      end
    end

    context 'for guest' do
      let(:current_user) { build_stubbed :guest_user }
      it { is_expected.to be_falsy }
    end
  end

  describe '#destroy?' do
    subject { policy.destroy? }

    context 'for admin' do
      let(:current_user) { build_stubbed :admin_user }
      it { is_expected.to be_truthy }
    end

    context 'for normal' do
      let(:current_user) { create :user }

      context 'owning the target scrapnote' do
        let(:target) { create :scrapnote, user: current_user }
        it { is_expected.to be_truthy }
      end

      context 'not owning the target scrapnote' do
        let(:target) { create :scrapnote }
        it { is_expected.to be_falsy }
      end
    end

    context 'for guest' do
      let(:current_user) { build_stubbed :guest_user }
      it { is_expected.to be_falsy }
    end
  end
end
