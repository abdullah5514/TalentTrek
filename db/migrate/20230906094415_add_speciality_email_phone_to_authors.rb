class AddSpecialityEmailPhoneToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :speciality, :string
    add_column :authors, :email, :string
    add_column :authors, :phone, :string
  end
end
