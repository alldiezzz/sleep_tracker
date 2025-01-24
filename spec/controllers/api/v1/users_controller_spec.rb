require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:followed_user) { create(:user) }

  describe 'POST #follow' do
    context 'when the user is successfully followed' do
      before do
        post :follow, params: { follow: { follower_id: user.id, followed_id: followed_user.id } }
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the success message' do
        expect(JSON.parse(response.body)['message']).to eq("Successfully followed user")
      end
    end

    context 'when the user is already followed' do
      before do
        create(:follow, follower: user, followed: followed_user)
        post :follow, params: { follow: { follower_id: user.id, followed_id: followed_user.id } }
      end

      it 'returns an ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the already following message' do
        expect(JSON.parse(response.body)['message']).to eq("You are already following this user")
      end
    end

    context 'when the follow action fails' do
      before do
        follow = build(:follow, follower: user, followed: followed_user)
        allow(follow).to receive(:save).and_return(false)
        allow(follow).to receive_message_chain(:errors, :full_messages).and_return([ "Error message" ])
        allow(Follow).to receive(:find_or_initialize_by).and_return(follow)
        post :follow, params: { follow: { follower_id: user.id, followed_id: followed_user.id } }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the error messages' do
        expect(JSON.parse(response.body)['errors']).to eq([ "Error message" ])
      end
    end
  end

  describe 'DELETE #unfollow' do
    context 'when the user is successfully unfollowed' do
      before do
        create(:follow, follower: user, followed: followed_user)
        delete :unfollow, params: { follow: { follower_id: user.id, followed_id: followed_user.id } }
      end

      it 'returns an ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the success message' do
        expect(JSON.parse(response.body)['message']).to eq("Successfully unfollowed the user")
      end
    end

    context 'when the follow relationship is not found' do
      before do
        delete :unfollow, params: { follow: { follower_id: user.id, followed_id: followed_user.id } }
      end

      it 'returns a not found status' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns the error message' do
        expect(JSON.parse(response.body)['error']).to eq("Follow relationship not found")
      end
    end
  end

  describe 'GET #sleep_sessions' do
    before do
      allow(IndexService).to receive(:get).with("sleep_session_user_#{user.id}").and_return({ sleep_sessions: [] })
      get :sleep_sessions, params: { user_id: user.id }
    end

    it 'returns an ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the sleep sessions' do
      expect(JSON.parse(response.body)).to eq({ "sleep_sessions" => [] })
    end
  end

  describe 'GET #followed_sleep_sessions' do
    before do
      user.followed << followed_user
      allow(IndexService).to receive(:get).with("sleep_session_user_#{followed_user.id}").and_return({ sleep_sessions: [] })
      get :followed_sleep_sessions, params: { user_id: user.id }
    end

    it 'returns an ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the followed sleep sessions' do
      expect(JSON.parse(response.body)).to eq([ { "sleep_sessions" => [] } ])
    end
  end
end
