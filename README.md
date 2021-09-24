# Confirm a booking

Within our sample booking application we have provisional bookings and we need to confirm these.

Upon confirming a booking, users associated with the booking may receive a confirmation message - this can be an email or an SMS.

The contents of the message is not important, its just that we trigger the appropriate message delivery method.

## Requirements

Create an rails API endpoint to transition a provisional booking to the confirmed state.

`PATCH /api/v1/bookings/:id/confirm`

### Params

|name|value|required|
|----|-----|--------|
|send_confirmation_msg|Boolean|N|
|confirmation_type|String (email, sms)|N|

1. Update the booking state from `provisional` to `confirmed` (see confirmation rules)

2. Set the timestamp for `confirmed_at` and who the user confirming the booking is

3. Send a confirmation notification to:

a. The user associated with the booking

b. The host associated with the booking (if the host is present)

- If `send_confirmation_msg` param is present then a confirmation message should be sent to both the booking user and the booking host
- If `confirmation_type` param is set to `:sms` then send a SMS (use `SMSSender.new(number, msg).deliver` - its in the lib directory)
- If `confirmation_type` param is set to `:email` then send a email
- If `confirmation_type` is not set then send an email

### Confirmation Rules

A booking will transition through many states in its lifetime.

|State|Description|
|-----|-----------|
|Provisional|Booking has just been made|
|Confirmed|Admin has confirmed bookings or user has paid for the booking|
|Cancelled|Admin or user has cancelled the booking|
|Expired|Booking was not confirmed and is in the past|

#### Rules

- Unapproved users cannot approve bookings
- Users can only approved their own bookings
- Bookings in the past cannot be confirmed
- Confirmed bookings cannot be re-confirmed
- Cancelled bookings cannot be confirmed
- Expired bookings cannot be confirmed

## Bonus Points

- Appropriate test coverage
- Design considerations
- Git history

## Time

We're looking for candidates to spend longer no than an hour working on this task.

## Submission

Clone the repo and submit a zip file back via email (don't fork as other candidates will then see the code samples)
