namespace :test_job do
  desc "Test to Run ProjectEmailJob"
  task run_test_job: :environment do
    ProjectEmailJob.perform_later(1)
  end
  #$ rake test_job:run_test_job
end
