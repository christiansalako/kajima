class Api::V1::BookingsController < ApplicationController
  require './lib/sms_sender'

  def confirm
    user = User.find(params[:id])
    booking = Booking.find(params[:id])

    if booking && user
      if booking_has_been_approved?(booking, user)
        booking_obj.time_stamp_approve(booking)
        booking_obj.booked_by_user(booking, user)
        booking.state = 'confirmed'
        booking.save
        booking_obj.confirmation_type(params, user, booking)
        booking_obj.host_and_user_message(params, user, booking)

        render json: { message: 'booking updated', status: 200 }
      else
        render json: { message: 'booking cannot be confirmed', status: 401 }
      end
    else
      render json: { message: 'unable to find user or booking', status: 404 }
    end
  end

  private

  def booking_obj
    Booking.new
  end

  def booking_has_been_approved?(booking, user)
    return true if booking_obj.approve_user(booking, user) && booking_obj.time_approve(booking) && booking.confirmed && booking_obj.cancelled_booking?(booking) && booking_obj.expired_booking?(booking) && booking_obj.confirmed_state_booking(booking)
    false
  end
end