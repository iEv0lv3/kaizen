class Users::VerificationController < Users::BaseController
  def verify_answer
    answer = Answer.find(params[:id])

    answer.verify_answer

    answer.save

    redirect_back(fallback_location: root_path)
  end
end
