require "../../spec_helper"

module HqTrivia::Connection
  describe Local do
    it "yields given messages" do
      msg = <<-MSG
      {"type":"interaction","ts":"2018-05-02T18:56:04.465Z","itemId":"chat","userId":5169584,"metadata":{"userId":5169584,"message":"🧠","avatarUrl":"https://d2xu1hdomh3nrx.cloudfront.net/72x72/default_avatars/Untitled-1_0001_blue.png","interaction":"chat","username":"kboogie1"},"sent":"2018-05-02T18:56:04.466Z"}
      MSG

      show = Model::Show.new(active: true, show_type: "hq-us", prize: 100, show_id: 666, start_time: Time.now)
      local = Local.new([msg])
      local.on_message do |msg|
        msg.should be_a(Model::Interaction)
      end
      local.connect(show, LocalCoordinator.new("us"))
    end
  end
end
