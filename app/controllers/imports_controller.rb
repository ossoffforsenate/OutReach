class ImportsController < ApplicationController
  before_action :require_admin

  def index
  end

  def create
    successful_uploads = []
    failed_uploads = []

    loader = ReachCsvLoader.new

    if params[:users_file]
      was_success = !loader.load_users(from: params[:users_file].tempfile)
      if was_success
        successful_uploads += ["Users"]
      else
        failed_uploads += ["Users"]
      end
    end

    if params[:voters_file]
      was_success = !loader.load_voters(from: params[:voters_file].tempfile)
      if was_success
        successful_uploads += ["Voters"]
      else
        failed_uploads += ["Voters"]
      end
    end

    if params[:relationships_file]
      was_success = !loader.load_relationships(from: params[:relationships_file].tempfile)
      if was_success
        successful_uploads += ["Relationships"]
      else
        failed_uploads += ["Relationships"]
      end
    end

    if (successful_uploads + failed_uploads).empty?
      flash[:warning] = "No uploads processed"
    end

    if failed_uploads.any?
      flash[:danger] = "Got errors handing import of: #{failed_uploads.join(", ")}. Please check the app logs."
    end

    if successful_uploads.any?
      flash[:success] = "Successfully imported: #{successful_uploads.join(", ")}"
    end

    redirect_to imports_path
  end

  private

  def require_admin
    unless current_user.is_admin
      flash[:danger] = 'You are not authorized to view that page'
      redirect_to relationships_path
    end
  end
end
