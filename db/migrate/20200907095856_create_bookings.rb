# frozen_string_literal: true

class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :user, index: true
      t.references :host, index: true
      t.datetime   :start_time
      t.datetime   :end_time
      t.datetime   :confirmed_at
      t.integer    :confirmed_by_id
      t.string     :state
      t.timestamps
    end
  end
end
