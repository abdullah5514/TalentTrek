class AddRollNoEmailPhoneToTalents < ActiveRecord::Migration[6.0]
  def change
    add_column :talents, :roll_no, :string
    add_column :talents, :email, :string
    add_column :talents, :phone, :string
  end
end
