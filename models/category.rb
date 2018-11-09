require_relative('../db/sql_runner')

attr_accessor :id, :name, :category_group_id

class Category

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @category_group_id = options['category_group_id'].to_i
  end

  CRUD


end
