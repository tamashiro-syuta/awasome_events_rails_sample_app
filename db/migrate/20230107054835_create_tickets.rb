class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      # 退会機能用にuserは、nullを許容する
      t.references :user
      t.references :event, null: false, foreign_key: true, index: false
      t.string :comment

      t.timestamps
    end

    # ユーザーがイベントに重複して参加できないよういevent_idとuser_idを複合したユニークインデックスを貼る
    # ※ event_id単体でのindexは不要になったので、上でeventのindexはfalseに設定
    add_index :tickets, %i[event_id user_id], unique: true
  end
end
