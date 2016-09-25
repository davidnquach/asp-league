require 'test_helper'

class MatchesControllerTest < ActionController::TestCase
  test 'redirects to index' do
    post :create, params: { summoner: { name: 'chizank' }, page: 0 }

    assert_redirected_to matches_path(id: 21609871, page: 0)
  end

  test 'gets the index' do
    get :index, params: { id: 21609871, page: 0 }

    assert_response :success
  end
end
