class EvaluationMailer < ActionMailer::Base
  default from: "no-reply@climorg.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.evaluation_mailer.evaluation_test.subject
  #
  def evaluation_test(research, evaluation)
    @research = research
    @evaluation = evaluation
    @employee = evaluation.employee

    mail to: @employee.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.evaluation_mailer.evaluation_reminder.subject
  #
  def evaluation_reminder(research, evaluation)
    @research = research
    @evaluation = evaluation
    @employee = evaluation.employee

    mail to: @employee.email
  end
end
