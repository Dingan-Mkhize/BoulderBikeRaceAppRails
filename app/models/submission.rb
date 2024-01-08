class Submission < ApplicationRecord
  before_validation :normalize_fields

  # Updated validation messages for more context
  validates :first_name, length: { minimum: 2, maximum: 100, too_short: 'must have at least 2 letters', too_long: 'must have at most 100 letters' }
  validates :last_name, length: { minimum: 2, maximum: 100, too_short: 'must have at least 2 letters', too_long: 'must have at most 100 letters' }
  validates :email, presence: { message: "can't be blank" }, uniqueness: { case_sensitive: false, message: 'has already been taken' }, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'is not a valid email format' }
  validates :slogan, length: { maximum: 50, too_long: 'must have at most 50 characters' }

  # Continue to use a custom validation method if needed
  validate :custom_validation_method

  private

  def normalize_fields
    self.email = email.downcase.strip
    self.first_name = first_name.strip
    self.last_name = last_name.strip
  end

  def custom_validation_method
    # Implement any custom validation logic here
    # Example: errors.add(:base, 'Custom error message') if some_condition
  end
end

