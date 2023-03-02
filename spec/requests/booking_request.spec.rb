require 'rails_helper'

RSpec.describe Api::V1::BookingsController, type: :request do
  describe 'POST bookings' do
    context 'valid post' do
      it 'when given correct params' do
        booking = create(:booking)
        user = create(:user)

        post api_v1_path(booking.id)

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["message"]).to eq 'booking updated'
      end

      it 'sends an email'
      it 'sends correct text'
    end


    context 'invalid post' do
      it 'when users are unapproved' do
        user = create(:user, :unapproved)
        booking = create(:booking)

        post api_v1_path(booking.id)

        expect(JSON.parse(response.body)["status"]).to eq 401
        expect(JSON.parse(response.body)["message"]).to eq 'booking cannot be confirmed'
      end

      it 'users that do not own bookings'

      it 'bookings with a past start date'

      it 'confirmed bookings'

      it 'expired bookings'
    end
  end
end