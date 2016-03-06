require_relative '../examples/policies_examples'

describe UserPolicy do
  let(:policy) { described_class.new(current_user, nil) }

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
