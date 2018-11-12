require_relative('../db/sql_runner')

class Category

  attr_accessor :id, :name, :category_group_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @category_group_id = options['category_group_id'].to_i
  end

# CREATE
  def save()
    sql = "
    INSERT INTO categories
    (name, category_group_id)
    VALUES ( $1, $2 )
    RETURNING id"
    values = [@name, @category_group_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

# READ
  def category_group()
    sql = "SELECT * FROM category_groups
    WHERE category_group_id = $1"
    values = [@category_group_id]
    category_group = SqlRunner.run( sql, values )
    return CategoryGroup.new(category_group)
  end

  def transactions()
    sql = "SELECT * FROM transactions
    WHERE category_id = $1"
    values = [@id]
    transactions = SqlRunner.run( sql, values )
    return transactions.map { |transaction| Transaction.new(transaction) }
  end

  def self.find(id)
    sql = "SELECT * FROM categories
    WHERE id = $1"
    values = [id]
    category = SqlRunner.run( sql )
    return Category.new( category )
  end

  def self.all()
    sql = "SELECT * FROM categories"
    categories = SqlRunner.run( sql )
    return categories.map { |category| Category.new( category ) }
  end

# UPDATE

def update()
    sql = "UPDATE categories
    SET (name, category_group_id) = ($1, $2)
    WHERE id = $3"
    values = [@name, @category_group_id, @id]
    SqlRunner.run(sql, values)
  end

# DELETE
  def delete()
    sql = "DELETE FROM categories
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.delete(id)
    sql = "DELETE FROM categories
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM categories"
    SqlRunner.run( sql )
  end

end
