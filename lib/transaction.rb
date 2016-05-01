class Transaction
  attr_reader :id, :customer, :product

  @@id = 1
  @@transactions = []

  def initialize(customer, product)
    product.decrease_stock
    @id = @@id
    @@id += 1
    @customer = customer
    @product = product
    @@transactions << self
  end

  def self.find_by_product_name(product_title)
    @@transactions.find{|transaction| transaction.product.title = product_title}
  end

  def self.find_by_customer_name(customer_name)
    @@transactions.find{|transaction| transaction.customer.name = customer_name}
  end

  def self.find(id)
    @@transactions.find{|transaction| transaction.id == id}
  end

  def self.all
    @@transactions
  end
end
