require 'csv'
class Student < ApplicationRecord
  validates :nome, :matricula, :email, :telefone, :status, presence: true
  validates :nome, format: { with: /\A[a-zA-Z .']+?\Z/, message: 'only allows letters' }
  validates :matricula, 
    length: { is: 6}, 
    format: { with: /\A\d{6}\Z/, message: 'only allows decimal numbers' }, uniqueness: true
  validates :telefone, 
    length: { is: 9}, 
    format: { with: /\A\d{9}\Z/, message: 'only allows decimal numbers' }, uniqueness: true
  validates :email, 
    uniqueness: true, 
    format: { 
      with: /\A[\w\-.]+?@(gmail|hotmail|yahoo|outlook)\.\w+?\Z/, 
      message: 'Must be like example@email.com' } 
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

  def has_uffmail?
    uffmail != nil
  end

  def self.create_records_from_file(file)
    # TODO Realizar verificação para o caso de uma trasação não funcionar
    CSV.foreach(file.path, headers: true) do |row|
      Student.create! row.to_hash
    end
  end

end
