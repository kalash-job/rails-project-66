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
    @cache_key = repositories_list_cache_key
  end

  def create
    @repository = current_user.repositories.find_or_initialize_by(repository_params)
    is_new_repository = @repository.new_record?

    if @repository.save
      ProcessNewRepositoryJob.perform_later(@repository.id) if is_new_repository
      redirect_to repositories_path, notice: t('.success')
    else
      flash.now[:failure] = t('.failure')
      @repositories_list = FetchRepositoriesListService.new(current_user.token).call
      render :new, status: :unprocessable_entity
    end
  end

  def invalidate_cache
    @cache_key = repositories_list_cache_key
    Rails.cache.delete(@cache_key)
    redirect_to new_repository_path, notice: t('.success')
  end

  private

  def repository_params
    params.require(:repository).permit(:github_id)
  end

  def repositories_list_cache_key
    "repositories_list_#{current_user.token}"
  end
end
