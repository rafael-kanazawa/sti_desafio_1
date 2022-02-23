class StudentsController < ApplicationController
  before_action :set_student, only: [:update, :generate_uffmail]

  # POST /students
  def create_with_csv
    # Um arquivo que poderia vir de um formulário multpart com input do tipo file
    if Student.create_records_from_file(params[:file])
      render json: @student, status: :created, location: @student
    else
      # TODO Cirar objeto errors
      render json: errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  def generate_uffmail_options
    uffmail_options = @student.uffmail_options
    if not uffmail_options.nil?
      render json: @student.uffmail_options, status: :ok
    else   
      render json: @student.errors, status: :ok
    end
  end

  def create
    @student = Student.new(student_params)
    @student.status = 'Ativo'
    if @student.save
      uffmail_options = @student.uffmail_options
      render json: { student: @student, uffmail_options: uffmail_options }, 
        status: :created, 
        location: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.require(:student).permit(:nome, :matricula, :telefone, :email, :uffmail, :status)
    end

end
