class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def self.movies(filters, sort_field)
    return self.order(sort_field) if not filters 
    self.where({:rating => filters}).order(sort_field)
  end

  def self.ratings
    self.pluck(:rating).uniq
  end

  def self.set_options(params, session)
    setup = { :redirect => false }

    setup[:ratings] = if params[:ratings]

      if params[:ratings].kind_of? Hash
        params[:ratings].keys
      else
        params[:ratings]
      end

    elsif session[:ratings]
      setup[:redirect] = true
      session[:ratings]
    else
      self.ratings
    end

    setup[:sort_by] = if params[:sort_by]
      params[:sort_by]
    elsif session[:sort_by]
      setup[:redirect] = true
      session[:sort_by]
    else
      nil
    end

    setup
  end
end
