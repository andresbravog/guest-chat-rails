require 'rails_helper'

RSpec.describe User do
  let(:params) { { username: 'andresbravog', dialect: :yoda } }
  let(:user) { User.new(params) }

  describe '#new' do
    subject { user }

    its(:username) { should eql 'andresbravog' }
    its(:dialect) { should eql :yoda }
  end

  describe '#valid' do
    subject { user }
    context 'with correct attributes' do
      it { should be_valid }
    end
    context 'without username attribute' do
      let(:params) { { dialect: :yoda } }

      it { should_not be_valid }
    end
    context 'without dialect attribute' do
      let(:params) { { username: 'andresbravog' } }

      it { should_not be_valid }
    end
    context 'with too short username attribute' do
      let(:params) { { username: 'and', dialect: :yoda } }

      it { should_not be_valid }
    end
    context 'with too long username attribute' do
      let(:params) { { username: rand(36**36).to_s(36), dialect: :yoda } }

      it { should_not be_valid }
    end
    context 'with not allowed dialect attribute' do
      let(:params) { { username: 'andresbravog', dialect: 'yodas' } }

      it { should_not be_valid }
    end
    context 'with allowed dialect string attribute' do
      let(:params) { { username: 'andresbravog', dialect: 'yoda' } }

      it { should be_valid }
      its(:dialect) { should eql :yoda }
    end
  end
end
