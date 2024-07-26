module CustomConfirmable
    extend ActiveSupport::Concern
  
    included do
      include Devise::Models::Confirmable
  
      def active_for_authentication?
        super && (confirmed? || (pre_existing_user? && within_grace_period?))
      end
  
      def confirmation_required?
        !(pre_existing_user? && within_grace_period?)
      end
  
      def confirmation_period_valid?
        return true if pre_existing_user? && within_grace_period?
        super
      end
  
      def pre_existing_user?
        created_at <= Rails.application.config.email_verification_cutoff_date
      end
  
      def within_grace_period?
        email_verification_deadline.present? && email_verification_deadline > Time.current
      end
  
      def grace_period_expired?
        pre_existing_user? && !confirmed? && email_verification_deadline.present? && email_verification_deadline <= Time.current
      end
    end
  end