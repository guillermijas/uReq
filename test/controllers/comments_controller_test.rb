require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
    @requirement = requirements(:one)
    @project = projects(:ureq)
    @user = users(:guille)
    @fer = users(:fer)
    @admin = users(:admin)
    sign_in(@user)
  end

  test 'should create comment' do
    assert_difference('Comment.count') do
      post project_requirement_comment_path(@project, @requirement), params: { comment: { body: @comment.body } }
    end
    assert_response :success
  end
  #
  #   test "should show comment" do
  #     get comment_url(@comment)
  #     assert_response :success
  #   end
  #
  #   test "should get edit" do
  #     get edit_comment_url(@comment)
  #     assert_response :success
  #   end
  #
  #   test "should update comment" do
  #     patch comment_url(@comment), params: { comment: { body: @comment.body } }
  #     assert_redirected_to comment_url(@comment)
  #   end
  #
  #   test "should destroy comment" do
  #     assert_difference('Comment.count', -1) do
  #       delete comment_url(@comment)
  #     end
  #
  #     assert_redirected_to comments_url
  #   end
end
