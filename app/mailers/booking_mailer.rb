class BookingMailer < ApplicationMailer
  def booking_confirm
    @user = User.find(params[:user][:id])

    mail(to: "#{@user&.email}", subject: 'Booking confirmed')
  end
end
