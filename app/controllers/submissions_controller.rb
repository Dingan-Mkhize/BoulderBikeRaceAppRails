class SubmissionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    @submission = Submission.new
  end

  def create
    existing_submission = Submission.find_by(email: submission_params[:email].downcase.strip)

    if existing_submission
      render json: { errors: [{ field: :email, messages: ['Submission with this email already exists.'] }] }, status: :unprocessable_entity
    else
      @submission = Submission.new(submission_params)

      if @submission.save
        render json: { message: 'Submission successful!' }, status: :ok
      else
        render json: { errors: format_errors(@submission.errors) }, status: :unprocessable_entity
      end
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:first_name, :last_name, :email, :slogan)
  end

  # Helper method to format the ActiveModel errors
  def format_errors(errors)
    errors.details.map do |field, details|
      messages = details.map do |error_detail|
        case error_detail[:error]
        when :blank
          "#{field.to_s.humanize} can't be blank"
        when :taken
          "#{field.to_s.humanize} has already been taken"
        when :too_long
          "#{field.to_s.humanize} is too long (maximum is #{error_detail[:count]} characters)"
        else
          "#{field.to_s.humanize} #{errors.messages[field].first}"
        end
      end
      { field: field, messages: messages }
    end
  end
end



