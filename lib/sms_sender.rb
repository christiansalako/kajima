class SMSSender
  def initialize(number, message)
    @number  = number
    @message = message
  end

  def deliver
    Rails.logger.info "MSG sent to #{number}"
  end

  private

  attr_reader :number, :message
end
