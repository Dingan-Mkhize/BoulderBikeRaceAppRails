require "test_helper"

class SubmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Setup any initial data here, like a valid submission for duplicate checks
    @existing_submission = Submission.create(
      first_name: 'Jane',
      last_name: 'Doe',
      email: 'jane@example.com',
      slogan: 'A neat slogan!'
    )
  end

  test "should get new" do
    get new_submission_url  # Assuming you have a route named 'new_submission'
    assert_response :success
  end

  test "should create submission" do
    assert_difference('Submission.count') do
      post submissions_url, params: { submission: { first_name: 'John', last_name: 'Doe', email: 'john@example.com', slogan: 'A great slogan!' } }
    end
    assert_response :success  # Or :redirect if you're redirecting after create
  end

  test "should not create invalid submission" do
    assert_no_difference('Submission.count') do
      post submissions_url, params: { submission: { first_name: '', last_name: '', email: 'invalid', slogan: 'This slogan is way too long and definitely exceeds the fifty character limit you have set in your model validations.' } }
    end
    assert_response :unprocessable_entity  # Expecting an unprocessable_entity response
    error_response = JSON.parse(response.body)
    assert_not_nil error_response['errors'], "Expected error messages but none found"
  end

  test "should not allow duplicate email" do
    assert_no_difference('Submission.count') do
      post submissions_url, params: { submission: { first_name: 'John', last_name: 'Doe', email: @existing_submission.email, slogan: 'Another great slogan!' } }
    end
    assert_response :unprocessable_entity
    error_response = JSON.parse(response.body)
    assert error_response['errors'].any? { |error| error['field'] == 'email' && error['messages'].include?('has already been taken') }, "Expected error message for duplicate email but none found"
  end

  # Add more tests for specific scenarios as needed
end

