require 'test_helper'

class KeywordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @keyword = keywords(:one)
    @user = users(:guille)
    @project = projects(:ureq)
    @requirement = requirements(:one)
  end

  test 'should get index' do
    get project_keywords_path(@project)
    assert_response :success
  end

  test 'should create keyword' do
    assert_difference('Keyword.count') do
      post project_keywords_path(@project), params: { keyword: { key: @keyword.key,
                                                                 definition: @keyword.definition } }
    end
    assert_equal(true, Requirement.find(@requirement.id).description.include?("<abbr title='#{@keyword.definition}'>"))
    assert_redirected_to project_keywords_path(@project)
  end

  test 'should get edit' do
    get edit_project_keyword_path(@project, @keyword), xhr: true
    assert_response :success
  end

  test 'should update keyword' do
    patch project_keyword_path(@project, @keyword), params: { keyword: { key: 'JSON' } }
    assert_equal(false, Requirement.find(@requirement.id).description.include?("<abbr title='#{@keyword.definition}'>"))
    assert_redirected_to project_keywords_path(@project)
  end

  test 'should destroy keyword' do
    assert_difference('Keyword.count', -1) do
      delete project_keyword_path(@project, @keyword)
    end
    assert_equal(false, Requirement.find(@requirement.id).description.include?("<abbr title='#{@keyword.definition}'>"))
    assert_redirected_to project_keywords_path(@project)
  end
end
