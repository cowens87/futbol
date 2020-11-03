require './test/test_helper'
require './lib/team'
require './lib/team_collection'

class TeamTest < Minitest::Test
  def setup
    data = {
            'team_id'      => '1',
            'franchiseId'  => '23',
            'teamName'     => 'Atlanta United',
            'abbreviation' => 'ATL',
            'Stadium'      => 'Mercedes-Benz Stadium',
            'link'         => '/api/v1/teams/1'
          }
    collection = mock('TeamCollection')
    @team      = Team.new(data, collection)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Team, @team
  end
end
