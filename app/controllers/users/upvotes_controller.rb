class Users::UpvotesController < Users::BaseController
  def question_upvotes
    question = Question.find(params[:id])

    create_vote(question)

    question.increment_upvotes

    redirect_to "/questions/#{question.id}"
  end

  def question_comment_upvotes
    question_comment = Comment.find(params[:id])

    create_vote(question_comment)

    question_comment.increment_upvotes
    redirect_to "/questions/#{question_comment.commentable_id}"
  end

  def answer_upvotes
    answer = Answer.find(params[:id])

    create_vote(answer)

    answer.increment_upvotes
    redirect_to "/questions/#{answer.question_id}"
  end

  def answer_comment_upvotes
    answer_comment = Comment.find(params[:id])

    create_vote(answer_comment)

    answer_comment.increment_upvotes
    redirect_to "/questions/#{answer_comment.commentable.question_id}"
  end

  private

  def create_vote(resource)
    vote = resource.votes.new
    vote.user_id = current_user.id
    vote.save
  end
end
