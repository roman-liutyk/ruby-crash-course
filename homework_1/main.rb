require "date"
require "set"

class Student
  attr_reader :name, :surname, :date_of_birth

  @@students = Set.new

  def initialize(name, surname, date_of_birth)
    raise ArgumentError, "Date of birth is not valid" if date_of_birth >= Date.today

    @name = name
    @surname = surname
    @date_of_birth = date_of_birth

		add_student
  end

  def calculate_age
  	current_date = Date.today

  	current_date.year - @date_of_birth.year - ((current_date.mon > @date_of_birth.mon) || (current_date.mon == @date_of_birth.mon && current_date.mday >= @date_of_birth.mday) ? 0 : 1)
  end

  def add_student
    @@students.add(self)
  end

	def self.remove_student(student)
    @@students.delete(student)
  end

	def self.get_students_by_age(age)
		@@students.select { |e| e.calculate_age == age }
	end

	def self.get_students_by_name(name)
		@@students.select { |e| e.name == name }
	end

  def eql?(other)
    @name == other.name && @surname == other.surname && @date_of_birth == other.date_of_birth
  end    

  def hash
    @name.hash ^ @surname.hash ^ @date_of_birth.hash
  end    
end

begin
	student1 = Student.new("Jack", "McCoy", Date.new(2004, 1, 1))   
	student2 = Student.new("Tom", "Perth", Date.new(2025, 1, 1))  
	
	p student1.calculate_age

	Student.add_student(student2)
rescue ArgumentError => e
	puts "Error: #{e.message}"
ensure
	student3 = Student.new("Jack", "McCoy", Date.new(2004, 1, 1))  
	student4 = Student.new("Max", "Jackson", Date.new(2004, 1, 1))  

	p Student.class_variable_get("@@students")
	p Student.get_students_by_age(20)
	p Student.get_students_by_name("Max")
	
	Student.remove_student(student1)

	p Student.class_variable_get("@@students")
end


