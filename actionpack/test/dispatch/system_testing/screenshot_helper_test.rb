require "abstract_unit"
require "action_dispatch/system_testing/test_helpers/screenshot_helper"

class ScreenshotHelperTest < ActiveSupport::TestCase
  test "image path is saved in tmp directory" do
    new_test = ActionDispatch::SystemTestCase.new("x")

    assert_equal "tmp/screenshots/x.png", new_test.send(:image_path)
  end

  test "image path includes failures text if test did not pass" do
    new_test = ActionDispatch::SystemTestCase.new("x")

    new_test.stub :passed?, false do
      assert_equal "tmp/screenshots/failures_x.png", new_test.send(:image_path)
    end
  end

  test "image path does not include failures text if test skipped" do
    new_test = ActionDispatch::SystemTestCase.new("x")

    new_test.stub :passed?, false do
      new_test.stub :skipped?, true do
        assert_equal "tmp/screenshots/x.png", new_test.send(:image_path)
      end
    end
  end
end
