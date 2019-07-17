class AddCommentsCount < ActiveRecord::Migration[5.2]
  def up
    add_column :articles, :comments_count, :integer, default: 0
    Article.all.each {|a| Article.reset_counters(a.id, :comments_count)}
  end
  def down
    remove_column :articles, :comments_count
  end
end
