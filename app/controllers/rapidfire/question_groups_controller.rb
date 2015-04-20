module Rapidfire
  class QuestionGroupsController < Rapidfire::ApplicationController
    before_filter :authenticate_administrator!, except: :index

    def index
      @question_groups = QuestionGroup.all
    end

    def new
      @question_group = QuestionGroup.new
    end

    def create
      @question_group = QuestionGroup.new(question_group_params)
      if @question_group.save
        respond_to do |format|
          format.html { redirect_to question_groups_path }
          format.js
        end
      else
        respond_to do |format|
          format.html { render :new }
          format.js
        end
      end
    end

    def destroy
      @question_group = QuestionGroup.find(params[:id])
      @question_group.destroy

      respond_to do |format|
        format.html { redirect_to question_groups_path }
        format.js
      end
    end

    def update
      @question_group = QuestionGroup.find(params[:id])
      @question_group.published = true
      @question_group.save
      redirect_to "/surveys"
    end

    def results
      @question_group = QuestionGroup.find(params[:id])
      @question_group_results =
        QuestionGroupResults.new(question_group: @question_group).extract

      respond_to do |format|
        format.json { render json: @question_group_results, root: false }
        format.html
        format.js
      end
    end

    def send_share_email
      @survey_owner = "test"
      @survey_link = "test"
      @participants = "morgan.a.emery@gmail.com".split(',')
      SharingMailer.share_email(@participants, @survey_owner, @survey_link).deliver_now
      redirect_to "/surveys"
    end

    private
    def question_group_params
      if Rails::VERSION::MAJOR == 4
        params.require(:question_group).permit(:name, :owner, :published)
      else
        params[:question_group]
      end
    end
  end
end
