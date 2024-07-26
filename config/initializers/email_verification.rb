#frozen_string_literal: true

Rails.application.config.email_verification_cutoff_date = Date.new(2024, 7, 21)
Rails.application.config.email_verification_grace_period = 30.days