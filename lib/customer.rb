require_relative "./errors"
require_relative "./transaction"

class Customer
  attr_reader :name, :purchases

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    @purchase_count = 0
    @purchases = []
    add_to_customers
  end

  def purchase(product)
    Transaction.new(self, product)
    @purchases << product
    @purchase_count += 1
  end

  def self.find_by_name(name)
    @@customers.find{|customer| customer.name == name}
  end

  def self.all
    @@customers
  end

  private

  def add_to_customers
    if @@customers.map{|customer| customer.name}.include?@name
      raise DuplicateCustomerError.new "#{@name} already exists."
    else
      @@customers << self
    end
  end
end
