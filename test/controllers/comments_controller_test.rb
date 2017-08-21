require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
    @requirement = requirements(:one)
    @project = projects(:ureq)
    @user = users(:guille)
    @admin = users(:admin)
    sign_in(@user)
  end

  test 'should create comment' do
    assert_difference('Comment.count') do
      post project_requirement_comments_path(@project.id, @requirement.id), xhr: true, params: { comment: { body: @comment.body } }
    end
    assert_response :success
  end

  test 'should destroy comment' do
    assert_difference('Comment.count', -1) do
      delete project_requirement_comment_path(@project.id, @requirement.id, @comment.id), xhr: true
    end
    assert_response :success
  end
end
