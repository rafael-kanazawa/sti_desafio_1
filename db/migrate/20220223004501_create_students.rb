class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :nome
      t.string :matricula
      t.string :telefone
      t.string :email
      t.string :uffmail
      t.integer :status

      t.timestamps
    end
  end
end
