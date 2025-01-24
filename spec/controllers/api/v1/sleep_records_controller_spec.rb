require 'rails_helper'

RSpec.describe Api::V1::SleepRecordsController, type: :controller do
  let(:user) { create(:user, name: 'John Doe') }

  describe 'POST #create' do
    context 'when the sleep session is successfully created' do
      before do
        allow(SleepRecords::StartSessionService).to receive(:call).with(user).and_return(OpenStruct.new(success?: true, data: { message: "Sleep session started successfully.", session_id: 1 }))
        post :create, params: { user_id: user.id }
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the success message' do
        expect(JSON.parse(response.body)['message']).to eq("Sleep session started successfully.")
      end
    end

    context 'when the sleep session creation fails' do
      before do
        allow(SleepRecords::StartSessionService).to receive(:call).with(user).and_return(OpenStruct.new(success?: false, error: "Error message"))
        post :create, params: { user_id: user.id }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the error message' do
        expect(JSON.parse(response.body)['error']).to eq("Error message")
      end
    end

    describe 'POST #add_event' do
    context 'when the event is successfully added' do
      before do
        allow(SleepRecords::AddEventService).to receive(:call).with(user, 'fall_asleep').and_return(OpenStruct.new(success?: true, data: { message: "Event added successfully.", event_type: 'fall_asleep' }))
        post :add_event, params: { user_id: user.id, event_type: 'fall_asleep' }
      end

      it 'returns an ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the success message' do
        expect(JSON.parse(response.body)['message']).to eq("Event added successfully.")
      end
    end

    context 'when adding the event fails' do
      before do
        allow(SleepRecords::AddEventService).to receive(:call).with(user, 'fall_asleep').and_return(OpenStruct.new(success?: false, error: "Error message"))
        post :add_event, params: { user_id: user.id, event_type: 'fall_asleep' }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the error message' do
        expect(JSON.parse(response.body)['error']).to eq("Error message")
      end
    end
  end
  end
end
