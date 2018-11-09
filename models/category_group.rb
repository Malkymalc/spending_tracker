require_relative('../db/sql_runner')

attr_accessor :id, :name, :colour

class CategoryGroup

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @colour = options['colour']
  end

end
