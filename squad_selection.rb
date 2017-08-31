# lib/squad_selection.rb

# Given a file (rugby_athletes.json below), containing a JSON encoded list of Squads and Athletes,
# plus a squad ID, output a starting 15 for a rugby team using the following criteria

# No players in the team should be injured
# The team should be a valid Rugby Union team
# (2 props, 1 hooker, 2 locks, 2 flankers, 1 Number Eight, 1 Scrum Half, 1 Out Half, 2 Centres, 2 Wingers, 1 Full Back)
# The output should contain at least the following:
# squad name, squad ID and a list of the players with their position, eg 'prop - Colm Doyle'

require "json"

class SquadSelection

    def load_json
        file = open(File.expand_path("../rugby_athletes.json", __FILE__))
        @json = JSON[file.read]
        rescue JSON::ParserError => e
            p "Invalid json"
    end

    # starting_squads returns all valid squads
    # A squad is valid if it has a fit player to fill each of the 15 positions
    def starting_squads

        valid_squads = []

        # remove all injured players
        # group players into squads
        # remove squads without enough players
        squads = remove_injured(@json["athletes"]).group_by {|athlete| athlete["squad_id"]}.sort.delete_if {|squad| squad[1].length < 15}

        squads.each do |squad|

            squad_info = @json["squads"][squad[0]]

            squad_details = {}
            squad_details["squad_club"] = squad_info["club"]
            squad_details["squad_name"] = squad_info["name"]
            squad_details["squad_id"] = squad_info["id"]

            players = []
            squad[1].each do |player|
                players << "#{player["position"]} - #{player["name"]}"
            end

            squad_details["squad_players"] = players.sort

            valid_squads << squad_details

        end

        if valid_squads.length > 0
            valid_squads
        else
            "Sorry no squads meet the requirements"
        end

    end

    def remove_injured(arr)
        if arr.length > 0
            arr.delete_if {|athlete| athlete["is_injured"]}
        else
            "Invalid athletes json array"
        end
    end

    def write_to_output
        output = File.open( "rugby_team.txt","w" )
        output << starting_squads
        output.close
    end

end

# initialisation
squad_selection = SquadSelection.new()
squad_selection.load_json
squad_selection.write_to_output
