require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include_context "session"

  let(:session_params) { { username: 'andresbravog', dialect: 'yoda' } }
  let(:user) { User.new(session_params) }
  let(:other_user) { User.new(session_params.merge(username: 'otheruser')) }

  describe '#new' do
    subject { get :new }
    it 'renders correctly' do
      subject
      expect(response.code).to eql('200')
    end
    context 'with already existing session' do
      subject { get :new, nil, session_for(user) }
      it 'redirects to root' do
        subject.should redirect_to root_path
      end
    end
  end

  describe '#create' do
    subject { post :create, session_params }
    it 'creates a new session' do
      subject
      expect(session[:username]).to eql(user.username)
      expect(session[:dialect]).to eql(user.dialect)
    end
    it 'redirects to root or previous page' do
      subject.should redirect_to root_path
    end
    context 'with already existing session' do
      subject { post :create, session_params, session_for(user) }
      it 'kill the existing session' do
        subject
        expect(session[:username]).to_not eql(other_user.username)
      end
    end
    context 'with invalid attributes' do
      subject { post :create, {} }
      it 'renders new with form errors' do
        subject
        expect(response.code).to eql('200')
        expect(flash[:warning]).to be_present
      end
    end
  end

  describe '#destroy' do
    subject { delete :destroy, nil, session_for(user)}
    it 'redirect to new session' do
      subject.should redirect_to login_path
    end
    it 'kill the existing session' do
      subject
      expect(session[:username]).to be_nil
    end
    context 'with no existing session' do
      subject { delete :destroy, nil, {} }
      it 'redirect to new session' do
        subject.should redirect_to login_path
      end
    end
  end
end
