class Database

  ATTRIBUTES = {
    :id => "INTEGER PRIMARY KEY AUTOINCREMENT",
    :url => "TEXT",
    :question => "TEXT",
    :upvotes => "INTEGER",
    :op_name => "TEXT",
    :op_link => "TEXT"
  }

  def self.save(discussion)

  end

end