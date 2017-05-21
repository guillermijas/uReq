require 'test_helper'
class RequirementsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @requirement = requirements(:one)
  end

  test "should get index" do
    get project_requirements_url(project_id: @requirement.project)
    assert_response :success
  end

  test "should get new" do
    get new_project_requirement_url(project_id: @requirement.project)
    assert_response :success
  end

test "should create requirement" do
  assert_difference('Requirement.count') do
    post project_requirements_url(project_id: @requirement.project,
                                  params: { requirement: { category: @requirement.category,
                                                           description: @requirement.description,
                                                           end_date: @requirement.end_date,
                                                           status: @requirement.status,
                                                           sufix: @requirement.sufix,
                                                           user_id: @requirement.user
                                  } })
  end
  assert_redirected_to project_requirement_path(Requirement.last.project, Requirement.last.id)
end

test "should show requirement" do
  get project_requirement_url(@requirement.project, @requirement)
  assert_response :success
end

test "should get edit" do
  get edit_project_requirement_url(@requirement.project, @requirement)
  assert_response :success
end

test "should update requirement" do
  patch project_requirement_url(@requirement.project, @requirement), params: { requirement: { category: @requirement.category, description: @requirement.description, end_date: @requirement.end_date, status: @requirement.status, sufix: @requirement.sufix } }
  assert_redirected_to project_requirement_path(@requirement.project, @requirement)
end

test "should destroy requirement" do
  assert_difference('Requirement.count', -1) do
    delete project_requirement_url(@requirement.project, @requirement)
  end

  assert_redirected_to project_requirements_path(@requirement.project)
end
=begin
=end
end
