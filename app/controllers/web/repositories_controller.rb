# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @repositories = current_user.repositories
  end

  def show
    @repository = Repository.find(params[:id])
    authorize @repository
  end

  def new
    @repositories_list = FetchRepositoriesListService.new(current_user.token).call
    @repository = Repository.new
  end

  def create
    @repository = current_user.repositories.find_or_initialize_by(repository_params)

    if @repository.save
      FetchRepositoryInfoJob.perform_later(@repository.id)
      redirect_to repositories_path, notice: t('.success')
    else
      flash.now[:failure] = t('.failure')
      @repositories_list = FetchRepositoriesListService.new(current_user.token).call
      render :new, status: :unprocessable_entity
    end
  end

  private

  def repository_params
    params.require(:repository).permit(:github_id)
  end
end
