class PagesController < ApplicationController
  def home
    @posts = Blog.all
    @skills = Skill.all
  end

  def about
    @skills = Skill.all
  end

  def contact; end

  def contact_us
    unless contact_us_params.present?
      redirect_to contact_path, notice: "Missing parameters!"
    end
    # UserMailer.submit_contact_us(params[:name], params[:email], params[:message], params[:subject]).deliver_now!
    # redirect_to contact_path, notice: "Thank you for contacting us!."
  end

  def tech_news
    @tweets = SocialTool.twitter_search
  end

  private

  def contact_us_params
    params.permit(:name, :email, :subject, :message)
  end
end
