class RenameYearFields < Mongoid::Migration
  def self.up
    Artwork.all.each do |a|
      a.numeric_year = a.year
      a.string_year = a.display_year
      a.save
    end
  end

  def self.down
    Artwork.all.each do |a|
      a.year = a.numeric_year
      a.display_year = a.string_year
      a.save
    end
  end
end
