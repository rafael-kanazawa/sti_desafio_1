class CSVTransaction 
  attr_accessor :errors

  def initialize()
    @errors = []
  end

  def create_records_from_file file_path
    CSV.foreach(file_path, headers: true) do |row|
      student = Student.new(row.to_hash)
      if student.valid?
        student.save
      else 
        errors << { student: student, errors: student.errors.messages }
      end
    end
  end
end