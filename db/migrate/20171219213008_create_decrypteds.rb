class CreateDecrypteds < ActiveRecord::Migration[5.1]
  def change
    create_table :decrypteds do |t|
      t.string :msg

      t.timestamps
    end
  end
end
