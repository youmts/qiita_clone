require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "trend" do
    let(:user) { create(:user) }
    let(:other1) { create(:user) }
    let(:other2) { create(:user) }
    let(:article) { create(:article, user: user)}

    before do
      10.times do
        a = create(:article, user: other1)
        other2.likes(a)
      end
    end

    it "期間内のいいね数をカウントすること" do
      other1.likes(article)
      other2.likes(article)

      expect(Article.trend(30.days, 10)).to include(article)
    end

    it "期間外のいいね数をカウントしないこと" do
      travel_to(Time.current.ago(31.days)) {
        other1.likes(article)
        other2.likes(article)
      }

      expect(Article.trend(30.days, 10)).not_to include(article)
    end
  end
end
