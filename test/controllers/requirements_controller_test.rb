require 'test_helper'

class RequirementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @requirement = requirements(:one)
    @requirement2 = requirements(:two)
    @project = projects(:ureq)
    @user = users(:guille)
    @fer = users(:fer)
    @admin = users(:admin)
    sign_in(@user)
  end

  test 'should get index' do
    get project_requirements_path(@project)
    assert_response :success
  end

  test 'should not get index' do
    sign_out(@user)
    sign_in(@fer)
    get project_requirements_path(@project)
    assert_redirected_to projects_path
  end

  test 'should select req' do
    get select_project_requirements_path(@project.id, @requirement.id), xhr: true
    assert_response :success
  end

  test 'should create requirement' do
    assert_difference('Requirement.count') do
      post project_requirements_path(@project), params: { requirement: { category: @requirement.category,
                                                                         description: @requirement.description,
                                                                         level: @requirement.level,
                                                                         status: @requirement.status,
                                                                         suffix: @requirement.suffix } }
    end
    assert_redirected_to project_requirements_path(@project)
  end

  test 'should not create requirement' do
    assert_no_difference('Requirement.count') do
      post project_requirements_path(@project), params: { requirement: { category: @requirement2.category,
                                                                         description: @requirement2.description,
                                                                         level: @requirement2.level,
                                                                         status: @requirement2.status,
                                                                         suffix: @requirement2.suffix } }
    end
  end

  test 'should edit req' do
    get edit_project_requirement_path(@project, @requirement), xhr: true
    assert_response :success
  end

  test 'should update requirement' do
    patch project_requirement_path(@project, @requirement), xhr: true, params: { requirement: { category: 'Seguridad',
                                                                                                description: 'Terminar login' } }
    assert_equal(Requirement.find(@requirement.id).category, 'Seguridad')
    assert_response :success
  end

  test 'should update requirement with keyword aplicacion' do
    patch project_requirement_path(@project, @requirement), xhr: true, params: { requirement: { category: 'Seguridad',
                                                                                                description: 'Terminar login aplicacion' } }
    assert_equal(true, Requirement.find(@requirement.id).description.include?('<abbr'))
    assert_response :success
  end

  test 'should destroy requirement' do
    assert_no_difference('Requirement.count') do
      delete project_requirement_path(@project, @requirement)
    end
    assert_equal(Requirement.find(@requirement.id).deleted, true)
    assert_redirected_to project_requirements_path(@project)
  end
end
