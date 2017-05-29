require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @project = projects(:one)
    @user = users(:guille)
    @admin = users(:admin)
    sign_in(@user)
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new" do
    get new_project_url
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count' && 'Log.count') do
      post projects_url, params: { project: { client: @project.client, end_date: @project.end_date, name: @project.name, status: @project.status } }
    end
    assert_equal(2, Project.last.user_projects.count)
    assert_equal(@user.id, Project.last.user_projects.first.user_id)
    assert_equal(@admin.id, Project.last.user_projects.last.user_id)
    assert_equal(true, Project.last.user_projects.first.owner)
    assert_equal(true, Project.last.user_projects.last.owner)
    assert_redirected_to projects_path
  end

  test "should not create project" do
    assert_no_difference('Project.count' || 'Log.count') do
      post projects_url, params: { project: {name: ''} }
    end
  end

=begin
  test "should get edit" do
    get edit_project_url(@project)
    assert_response :success
  end

  test "should update project" do
    patch project_url(@project), params: { project: { client: @project.client, end_date: @project.end_date, name: @project.name, status: @project.status } }
    assert_redirected_to project_url(@project)
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
  end
=end
end
