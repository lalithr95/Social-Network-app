class AddResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_digest, :string,default: nil
    add_column :users, :reset_sent_at, :datetime
  end
end
