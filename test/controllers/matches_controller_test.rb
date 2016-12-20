require 'test_helper' 

class MatchesControllerTest < ActionController::TestCase
  test 'redirects to index' do
    json = {
      doublelift: {
        id: 20132258,
        name: 'Doublelift',
        profileIconId: 1310,
        revisionDate: 1482196823000,
        summonerLevel: 30
      }
    }.to_json

    stub_request(:get, /.*/).to_return(body: json)
    post :create, params: { summoner: { name: 'Doublelift' }, page: 0 }

    assert_redirected_to matches_path(id: 20132258, page: 0)
  end

  test 'gets the index' do
    # get :index, params: { id: 21609871, page: 0 }

    # assert_response :success
  end
end
