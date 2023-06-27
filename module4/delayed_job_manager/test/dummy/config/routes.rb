Rails.application.routes.draw do
  mount DelayedJobManager::Engine => "/delayed_job_manager"
end
