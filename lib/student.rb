class Student

  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    students = DB[:conn].execute("CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT)")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES('#{self.name}', '#{self.grade}')")
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    new_student = Student.new(name, grade)
    new_student.save 
    new_student
  end    

  
end
