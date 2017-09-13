require 'test_helper'

class LogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project_manager = users(:guille)
    @admin = users(:admin)
    @log = logs(:one)
    sign_in(@admin)
  end

  test 'should get index' do
    get logs_path
    assert_response :success
  end

  test 'should not get index' do
    sign_out(@admin)
    sign_in(@project_manager)
    get logs_path
    assert_redirected_to projects_path
  end
end
