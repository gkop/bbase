class City
  include Mongoid::Document
  field :name, :type => String
  field :state, :type => String
  field :country, :type => String
  
  references_many :sites

  validates_presence_of :name

  def self.find_or_create(params)
    @city = City.first(:conditions => { :name => params[:name] })
    @city = City.new(params) unless @city
    @city.save
  end

end
