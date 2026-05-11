class MakeAdminUser < ActiveRecord::Migration[7.1]
  def up
    user = User.find_by(email: "adhcamus@gmail.com")
    user.update!(admin: true) if user
  end

  def down
    user = User.find_by(email: "adhcamus@gmail.com")
    user.update!(admin: false) if user
  end
end
