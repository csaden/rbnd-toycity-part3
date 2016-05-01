require_relative "./errors"

class Product
  attr_reader :title, :price, :stock

  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
  end

  def decrease_stock(amount=1)
    @stock -= amount
  end

  def in_stock?
    @stock > 0
  end

  def self.in_stock
    @@products.find_all {|product| product.in_stock?}
  end

  def self.find_by_title(title)
    @@products.find {|product| product.title == title}
  end

  def self.all
    @@products
  end

  private

  def add_to_products
    if @@products.map{|product|product.title}.include?@title
      raise DuplicateProductError.new "#{@title} already exists."
    else
      @@products << self
    end
  end
end
