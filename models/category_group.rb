require_relative('../db/sql_runner')

class CategoryGroup

  attr_accessor :id, :name, :colour

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @colour = options['colour'] || '#eee'
  end

# CREATE
  def save()
    sql = "
    INSERT INTO category_groups
    (name, colour)
    VALUES ( $1, $2 )
    RETURNING id"
    values = [@name, @colour]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

# READ
  def categories()
    sql = "SELECT * FROM categories
    WHERE category_group_id = $1"
    values = [@id]
    categories = SqlRunner.run( sql, values )
    return categories.map { |category| Category.new(category) }
  end

  def transactions()
    sql = "SELECT * FROM transactions
    INNNER JOIN categories
    ON transactions.category_id = categories.id
    INNER JOIN category_groups
    ON categories.category_group_id = category_groups.id
    WHERE category_group_id = $1"
    values = [@id]
    transactions = SqlRunner.run( sql, values )
    return transactions.map { |transaction| Transaction.new(transaction) }
  end

  def self.find(id)
    sql = "SELECT * FROM category_groups
    WHERE id = $1"
    values = [id]
    category_group = SqlRunner.run( sql, values )[0]
    return  CategoryGroup.new( category_group )
  end

  def self.all()
    sql = "SELECT * FROM category_groups"
    results = SqlRunner.run( sql )
    return results.map { |category_group| CategoryGroup.new( category_group ) }
  end

# UPDATE

def update()
    sql = "UPDATE category_groups
    SET (name, colour) = ($1, $2)
    WHERE id = $3"
    values = [@name, @colour, @id]
    SqlRunner.run(sql, values)
  end

# DELETE
  def delete()
    sql = "DELETE FROM category_groups
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.delete(id)
    sql = "DELETE FROM category_groups
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM category_groups"
    SqlRunner.run( sql )
  end

end
