require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  WebMock.allow_net_connect!
  driven_by :selenium, using: :headless_chrome
end
