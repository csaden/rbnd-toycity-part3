require_relative "./errors"
require_relative "./transaction"

class Customer
  attr_reader :name, :purchases

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    @purchase = 0
    @items = []
    add_to_customers
  end

  def purchase(product)
    if product.in_stock?
      Transaction.new(self, product)
      @purchase += 1
    else
      raise OutOfStockError.new "#{product.title} is out of stock."
    end
  end

  def self.find_by_name(name)
    @@customers.find{|customer| customer.name == name}
  end

  def self.all
    @@customers
  end

  private

  def add_to_customers
    if @@customers.include?(self)
      raise DuplicateProductError.new "#{@name} already exists."
    else
      @@customers << self
    end
  end
end
