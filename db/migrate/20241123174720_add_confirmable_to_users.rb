class AddConfirmableToUsers < ActiveRecord::Migration[7.0]
  # up is for running the migration and down is for rollbacks 
  def up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :users, :confirmation_token, unique: true
  end

  def down
    remove_index :users, :confirmation_token # Remove this line if index wasn’t added
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
  end
end