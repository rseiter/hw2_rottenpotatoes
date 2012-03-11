class Movie < ActiveRecord::Base
  def self.all_ratings
    # How can I get these from the db?
    return ['G','PG','PG-13','R']
  end
end
