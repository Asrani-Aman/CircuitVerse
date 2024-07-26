class AddEmailVerificationDeadlineToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_verification_deadline, :datetime
  end
end
