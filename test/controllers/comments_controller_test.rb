require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
    @requirement = @comment.requirement
    @project = @requirement.project
  end

  test "should get index" do
    get project_requirements_url(project_id: @comment.requirement.project, requirement_id: @comment.requirement)
    assert_response :success
  end

=begin
  test "should get new" do
    get new_project_requirement_comment_url(@project, @requirement, @comment)
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { body: @comment.body } }
    end

    assert_redirected_to comment_url(Comment.last)
  end

  test "should show comment" do
    get comment_url(@comment)
    assert_response :success
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to comments_url
  end

=end
end
