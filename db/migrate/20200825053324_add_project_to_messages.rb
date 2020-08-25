class AddProjectToMessages < ActiveRecord::Migration[6.0]
  def change
    Message.destroy_all
    add_reference :messages, :project, null: false, foreign_key: true
    remove_reference :messages, :chatroom
    drop_table :chatrooms
  end
end
