class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def self.movies(filters, sort_field)
    return self.order(sort_field) if not filters 
    self.where({:rating => filters.keys}).order(sort_field)
  end

  def self.ratings
    self.pluck(:rating).uniq
  end
end
