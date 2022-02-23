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
    if not self.active?
      self.errors.add(:uffmail_options, 'student must be active active')
      return nil
    elsif self.has_uffmail?
      self.errors.add(:uffmail_options, 'student already has a uffmail')
      return nil
    else   
      options = []
      names = nome.split.map {|s| s.downcase}
      first_name = names.shift
      names.map {|s| "#{first_name}.#{s}@id.uff.br" }
    end
  end

  def active?
    status == 'Ativo'
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
