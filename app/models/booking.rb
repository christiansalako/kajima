# frozen_string_literal: true

class Booking < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :host, optional: true
  belongs_to :confirmed_by, class_name: 'User', optional: true

  validates :start_time, presence: true
  validates :end_time, presence: true

  aasm do
    state :provisional
    state :confirmed
    state :cancelled
    state :expired

    event :confirmed do
      transitions from: [:provisional], to: :confirmed
    end

    event :cancel do
      transitions from: [:confirmed], to: :cancelled
    end

    event :expiry do
      transitions from: [:provisional], to: :expired
    end
  end

  def confirmed_state_booking(booking)
    return false if booking.state == 'confirmed' && booking.aasm_state == 'provisional'
    true
  end

  def approve_user(booking, user)
    return true if user.approved && booking.user_id == user.id
    false
  end

  def time_approve(booking)
    booking.start_time > Time.now
  end

  def cancelled_booking?(booking)
    booking.state == 'cancelled' ? false : true
  end

  def expired_booking?(booking)
    true if booking.end_time > Time.now
  end

  def time_stamp_approve(booking)
    booking.confirmed_at = Time.now
  end

  def booked_by_user(booking, user)
    booking.confirmed_by_id = user.id
  end

  def confirmation_type(params, user, booking)
    confirmation_type = params["confirmation_type"]

    case confirmation_type
    when "email"
      BookingMailer.with(user: user, booking: booking).booking_confirm.deliver_now
    when "sms"
      SMSSender.new(user.mobile, 'you have a message').deliver
    else
      BookingMailer.with(user: user, booking: booking).booking_confirm.deliver_now
    end
  end

  def host_and_user_message(params, user, booking)
    # send email to host and user if below present
    if params["send_confirmation_msg"].present?
      SMSSender.new(user.mobile, 'you have a message').deliver
      BookingMailer.with(user: user, booking: booking).booking_confirm.deliver_now
    end
  end
end
