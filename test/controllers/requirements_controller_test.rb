require 'test_helper'

class RequirementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @requirement = requirements(:one)
    @project = projects(:ureq)
    @user = users(:guille)
    @fer = users(:fer)
    @admin = users(:admin)
  end

  test 'should get index' do
    sign_in(@user)
    get project_requirements_path(@project)
    assert_response :success
  end

  test 'should not get index' do
    sign_in(@fer)
    get project_requirements_path(@project)
    assert_redirected_to projects_path
  end

  #   test "should get new" do
  #     get new_requirement_url
  #     assert_response :success
  #   end
  #
  #   test "should create requirement" do
  #     assert_difference('Requirement.count') do
  #       post requirements_url, params: { requirement: { category: @requirement.category, description: @requirement.description, end_date: @requirement.end_date, level: @requirement.level, status: @requirement.status, suffix: @requirement.suffix } }
  #     end
  #
  #     assert_redirected_to requirement_url(Requirement.last)
  #   end
  #
  #   test "should show requirement" do
  #     get requirement_url(@requirement)
  #     assert_response :success
  #   end
  #
  #   test "should get edit" do
  #     get edit_requirement_url(@requirement)
  #     assert_response :success
  #   end
  #
  #   test "should update requirement" do
  #     patch requirement_url(@requirement), params: { requirement: { category: @requirement.category, description: @requirement.description, end_date: @requirement.end_date, level: @requirement.level, status: @requirement.status, suffix: @requirement.suffix } }
  #     assert_redirected_to requirement_url(@requirement)
  #   end
  #
  #   test "should destroy requirement" do
  #     assert_difference('Requirement.count', -1) do
  #       delete requirement_url(@requirement)
  #     end
  #
  #     assert_redirected_to requirements_url
  #   end
end
