# lib/squad_selection_spec.rb
require_relative '../squad_selection'

describe "squad_selection" do

    athletes = [
        {
          "avatar_url" => "https://kitmanlabs.com/avatars/athletes/0.jpg",
          "squad_id" => 5,
          "country" => "Korea (North)",
          "last_played" => "Sun Mar 15 2015 15:58:00 GMT+0000 (UTC)",
          "name" => "Meagan Gill",
          "position" => "prop",
          "is_injured" => true,
          "id" => 0
        },
        {
          "avatar_url" => "https://kitmanlabs.com/avatars/athletes/1.jpg",
          "squad_id" => 2,
          "country" => "Falkland Islands (Malvinas)",
          "last_played" => "Thu Mar 05 2015 19:46:18 GMT+0000 (UTC)",
          "name" => "Hillary Wiggins",
          "position" => "full-back",
          "is_injured" => false,
          "id" => 1
        },
        {
          "avatar_url" => "https://kitmanlabs.com/avatars/athletes/2.jpg",
          "squad_id" => 8,
          "country" => "Bulgaria",
          "last_played" => "Fri Sep 11 2015 14:52:35 GMT+0000 (UTC)",
          "name" => "Bright Hicks",
          "position" => "centre",
          "is_injured" => true,
          "id" => 2
        }
    ]

    fit_athletes = [
        {
          "avatar_url" => "https://kitmanlabs.com/avatars/athletes/1.jpg",
          "squad_id" => 2,
          "country" => "Falkland Islands (Malvinas)",
          "last_played" => "Thu Mar 05 2015 19:46:18 GMT+0000 (UTC)",
          "name" => "Hillary Wiggins",
          "position" => "full-back",
          "is_injured" => false,
          "id" => 1
        }
    ]

    unfit_athletes = [
        {
          "avatar_url" => "https://kitmanlabs.com/avatars/athletes/0.jpg",
          "squad_id" => 5,
          "country" => "Korea (North)",
          "last_played" => "Sun Mar 15 2015 15:58:00 GMT+0000 (UTC)",
          "name" => "Meagan Gill",
          "position" => "prop",
          "is_injured" => true,
          "id" => 0
        },
        {
          "avatar_url" => "https://kitmanlabs.com/avatars/athletes/2.jpg",
          "squad_id" => 8,
          "country" => "Bulgaria",
          "last_played" => "Fri Sep 11 2015 14:52:35 GMT+0000 (UTC)",
          "name" => "Bright Hicks",
          "position" => "centre",
          "is_injured" => true,
          "id" => 2
        }
    ]

    valid_squad = [
        {
            "squad_club" => "Kenegy",
            "squad_name" => "Squad 3",
            "squad_id" => 3,
            "squad_players" => [
                "centre - Lawanda Maddox",
                "centre - Sheryl Sexton",
                "flanker - Brianna Knapp",
                "flanker - Kaufman Ferrell",
                "full-back - Willie Dunn",
                "hooker - Clarice Shepherd",
                "lock - Calderon Byrd",
                "lock - Courtney Wells",
                "number-eight - Knapp Stanley",
                "out-half - Caitlin House",
                "prop - Mercedes Whitehead",
                "prop - Ratliff Avery",
                "scrum-half - Pennington Rollins",
                "winger - Diana Wiley",
                "winger - Schmidt Banks"
            ]
        }
    ]

    it "removes injured players from players array" do
        squad_selection = SquadSelection.new()
        expect(squad_selection.remove_injured(athletes)).to eq fit_athletes
    end

    it "displays error for invalid athletes array" do
        squad_selection = SquadSelection.new()
        expect(squad_selection.remove_injured([])).to eq "Invalid athletes json array"
    end

    it "returns a valid squad list" do
        squad_selection = SquadSelection.new()
        squad_selection.load_json
        expect(squad_selection.starting_squads).to eq valid_squad
    end

end
