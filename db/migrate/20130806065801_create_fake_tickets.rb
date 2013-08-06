class CreateFakeTickets < ActiveRecord::Migration
  def change
    create_table :fake_tickets do |t|

      t.timestamps
    end
  end
end
