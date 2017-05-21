require 'test_helper'

class GlosariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @glosario = glosarios(:one)
  end

  test "should get index" do
    get glosarios_url
    assert_response :success
  end

  test "should get new" do
    get new_glosario_url
    assert_response :success
  end

  test "should create glosario" do
    assert_difference('Glosario.count') do
      post glosarios_url, params: { glosario: { definition: ('a'..'z').to_a.shuffle[0,8].join, key: ('a'..'z').to_a.shuffle[0,8].join } }
    end

    assert_redirected_to glosario_url(Glosario.last)
  end

  test "should show glosario" do
    get glosario_url(@glosario)
    assert_response :success
  end

  test "should get edit" do
    get edit_glosario_url(@glosario)
    assert_response :success
  end

  test "should update glosario" do
    patch glosario_url(@glosario), params: { glosario: { definition: @glosario.definition, key: @glosario.key } }
    assert_redirected_to glosario_url(@glosario)
  end

  test "should destroy glosario" do
    assert_difference('Glosario.count', -1) do
      delete glosario_url(@glosario)
    end

    assert_redirected_to glosarios_url
  end
end
