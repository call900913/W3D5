require_relative 'db_connection'
require 'active_support/inflector'


# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    cols = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT
        0
    SQL

    cols.map!(&:to_sym)
    @columns = cols
  end


  def self.finalize!

    return @columns if @columns
    self.columns.each do |name|

      define_method(name) do
        self.attributes[name]
      end

      define_method("#{name}=") do |value|
        self.attributes[name] = value
      end
    end
  end



  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    #using the inflector from active_support
    @table_name || name.underscore.pluralize

    # name.downcase.chars.join('') + 's'
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...

    params.each do |k, v|
      k = k.to_sym

      if self.class.columns.include?(k)
        self.send("#{k}=", v)
      else
        raise "unknown attribute '#{k}'"
      end

    end
  end
=begin
params.each do |attr_name, value|
  # make sure to convert keys to symbols
  attr_name = attr_name.to_sym
  if self.class.columns.include?(attr_name)
    self.send("#{attr_name}=", value)
  else
    raise "unknown attribute '#{attr_name}'"
  end
end

=end
  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...

  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
