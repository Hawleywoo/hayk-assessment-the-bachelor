require "pry"


def get_season seasons, season_labels
  seasons.select do |season|
    season == season_labels
  end
end

def get_season_winner seasons, season_labels
  contestants = get_season(seasons, season_labels)[season_labels]
  contestants.find do |contestant|
    contestant['status'] == 'Winner'
  end
end

def all_contestants seasons 
  seasons.reduce([]) do |all_contestants, (season_label,contestants)|
    contestants_with_season = contestants.map do |contestant|
      contestant["season"] = season_label
      contestant
    end
    all_contestants.concat contestants_with_season
  end
end

def get_first_name_of_season_winner seasons, season_labels
  winner = get_season_winner(seasons, season_labels)
  first_name = winner['name'].split(' ').first
end

def get_contestant_name seasons, occupation
  all_contestants(seasons).find do |contestant|
    contestant['occupation'] == occupation
  end ['name']
end

def count_contestants_by_hometown(seasons, hometown)
  contestants_from_hometown = all_contestants(seasons).select do |contestant|
    contestant['hometown'] == hometown
  end
  contestants_from_hometown.count
end

def get_occupation(seasons, hometown)
  all_contestants(seasons).find do |contestant|
    contestant['hometown'] == hometown
  end['occupation']
end

def get_average_age_for_season(seasons, season)
  contestants_age = all_contestants(seasons).reduce([]) do |contestants_age, contestant|
    if contestant['season'] == season
      contestants_age << contestant["age"]
    else  
      contestants_age
    end
  end
  total_contestants_age = contestants_age.reduce(0) do |sum, contestant_age|
    sum + contestant_age.to_f
  end

  average_age = (total_contestants_age / contestants_age.count).round
end
