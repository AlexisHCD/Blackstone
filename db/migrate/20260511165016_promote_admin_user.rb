class PromoteAdminUser < ActiveRecord::Migration[7.1]
  def up
    User.where(email: "gmkeled@gmail.com").update_all(admin: true)
  end

  def down
    # nothing
  end
end
