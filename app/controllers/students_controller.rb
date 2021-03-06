class StudentsController < ApplicationController
  before_action :set_student, only: [:update, :generate_uffmail_options, :set_uffmail]

  # POST /students
  def create_with_csv
    importer = Student.create_with_csv(params[:file].path)
    if importer.errors.empty?
      render json: {message: 'Students were created succefully'}, status: :created
    else
      render json: importer.errors, status: :unprocessable_entity
    end
  end

  def set_uffmail
    if @student.update(uffmail_param)
      render json: {
        student: @student, 
        message: "Sua conta no dominico id.uff será criada em breve e um SMS contendo sua primeira senha será enviado para numero cadastrado."
      }
    else
      render json: @student.errors, status: :unprocessable_entity
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
      render json:{ uffmail_options: @student.uffmail_options }, status: :ok
    else   
      render json:{ uffmail_options: nil, errors: @student.errors }, status: :ok
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

    def uffmail_param
      params.require(:student).permit(:uffmail)
    end

end
