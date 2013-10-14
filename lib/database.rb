require 'sqlite3'

class Database

  @@discussion = nil

  ATTRIBUTES = {
    :id => "INTEGER PRIMARY KEY AUTOINCREMENT",
    :url => "TEXT",
    :question => "TEXT",
    :upvotes => "INTEGER",
    :op_name => "TEXT",
    :op_link => "TEXT"
  }

  @@db = SQLite3::Database.new('stackoverflow.db')

  def self.create_table
    create = "CREATE TABLE IF NOT EXISTS #{@@discussion.class.to_s.downcase}s (#{columns_for_schema})"
    @@db.execute(create)
  end

  def self.save(discussion)
    @@discussion = discussion
    create_table
    if @@discussion.saved?
      update
    else
      insert
    end
  end

  def self.columns_for_schema
    attributes.zip(attribute_types).map { |pair| pair.join(' ') }.join(',')
  end

  def self.get_question_marks
    "?" + ",?"*(attributes.size-1)
  end

  def self.get_question_marks_for_insert
    "?" + ",?"*(attributes_for_db_insert.size-1)
  end

  def self.update
  end

  def self.get_object_attributes
    attributes_for_db_insert.map do |attribute|
      @@discussion.send("#{attribute.to_s}")
    end
  end

  def self.insert
    insert = "INSERT INTO #{@@discussion.class.to_s.downcase}s (#{attributes_for_column_names}) VALUES (#{get_question_marks_for_insert})"
    @@db.execute(insert, get_object_attributes)
    @@discussion.saved = true
  end

  def self.new_from_row
  end

  def self.attributes
    ATTRIBUTES.keys
  end

  def self.attribute_types
    ATTRIBUTES.values
  end

  def self.attributes_for_column_names
    attributes_for_db_insert.map { |attribute| attribute.to_s }.join(',')
  end

  def self.attributes_for_db_insert
    ATTRIBUTES.keys[1..-1]
  end

  def self.find
  end

end