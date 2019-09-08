require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#articles_tags_count" do
    let(:user) { create(:user) }

    it "ユーザが作った記事につけられたタグの数を返すこと" do
      create(:article, user: user, tag_list: %w(a b))
      create(:article, user: user, tag_list: %w(a c))

      expect(user.articles_tags_count).to eq({"a" => 2, "b" => 1, "c" => 1})
    end
  end
end
