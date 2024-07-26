class BackfillUserConfirmations < ActiveRecord::Migration[7.0]
  def up
    grace_period = Rails.application.config.email_verification_grace_period
    cutoff_date = Rails.application.config.email_verification_cutoff_date
    User.where(confirmation_sent_at: nil)
        .where("created_at <= ?", cutoff_date)
        .update_all(
          email_verification_deadline: Time.current + grace_period
        )
  end

  def down
    cutoff_date = Rails.application.config.email_verification_cutoff_date
    User.where("created_at <= ?", cutoff_date).update_all(
      confirmed_at: nil, a
      email_verification_deadline: nil
    )
  end
end
