class AddStatusToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :status, :string, default: "draft"

    Article.update_all(status: :open)
  end
end
