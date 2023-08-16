# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @repositories = current_user.repositories.by_id
  end

  def show
    @repository = Repository.find(params[:id])
    authorize @repository
  end

  def new
    @repositories_list = fetch_repositories_list
    @repository = Repository.new
    @cache_key = repositories_list_cache_key
  end

  def create
    @repository = current_user.repositories.find_or_initialize_by(repository_params)
    return redirect_to_repositories if @repository.persisted?

    if @repository.save
      process_new_repository
      redirect_to_repositories
    else
      flash.now[:failure] = t('.failure')
      @repositories_list = fetch_repositories_list
      @cache_key = repositories_list_cache_key
      render :new, status: :unprocessable_entity
    end
  end

  def invalidate_cache
    Rails.cache.delete(repositories_list_cache_key)
    redirect_to new_repository_path, notice: t('.success')
  end

  private

  def repository_params
    params.require(:repository).permit(:github_id)
  end

  def repositories_list_cache_key
    "repositories_list_#{current_user.token}"
  end

  def process_new_repository
    ProcessNewRepositoryJob.perform_later(@repository.id)
  end

  def fetch_repositories_list
    FetchRepositoriesListService.new(current_user.token).call
  end

  def redirect_to_repositories
    redirect_to repositories_path, notice: t('.success')
  end
end
