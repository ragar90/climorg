require 'test_helper'

class EvaluationMailerTest < ActionMailer::TestCase
  test "evaluation_test" do
    mail = EvaluationMailer.evaluation_test
    assert_equal "Evaluation test", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "evaluation_reminder" do
    mail = EvaluationMailer.evaluation_reminder
    assert_equal "Evaluation reminder", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
