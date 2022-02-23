require 'csv'
class Student < ApplicationRecord
  validates :nome, :matricula, :email, :telefone, :status, presence: true
  VALID_STATUS = {Ativo: 0, Inativo: 1}
  enum status: VALID_STATUS

  def uffmail_options
    # Pega o nome e divide em substrings separadas por ' '
    # Toma as substrings dois a dois, gera conjuntos e concatena com '@id.uff.br'
    # Retorna um vetor dos conjuntos gerados
  end

  def active?
    status == :Ativo
  end

  def uffmail?
    uffmail != nil
  end

  def self.create_records_from_file(file)
    # TODO Realizar verificação para o caso de uma trasação não funcionar
    CSV.foreach(file.path, headers: true) do |row|
      Student.create! row.to_hash
    end
  end

end
