class PostReportJob < ApplicationJob
  queue_as :default

  #se recomienda pasar valores cortos y no modelos complejos
  def perform(user_id, post_id)
    # Do something later
    # user -> report post -> email report
    user = User.find(user_id);
    post = Post.find(post_id);

    #generar reporte por una clase
    report = PostReport.generate(post);

    #enviar mail
    PostReportMailer.post_report(user, post, report).deliver_now
  end

end
