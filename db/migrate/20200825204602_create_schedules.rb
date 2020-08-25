class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.integer :project_id
      t.integer :map_id
      t.integer :area_id
      t.string :lease_execution_date
      t.string :final_plans_received_date
      t.string :final_plans_reviewed_date
      t.string :permit_submitted_date
      t.string :permit_received_date
      t.string :premises_acceptance_date
      t.string :construction_completion_date
      t.string :open_for_business_date
      t.integer :total_days
      t.integer :design_duration
      t.integer :ll_review_duration
      t.integer :permit_submittal_duration
      t.integer :permit_reviewed_duration
      t.integer :mobilization_duration
      t.integer :tenant_fit_out_duration
      t.integer :merchandising_duration
      t.belongs_to :area, index: true, foreign_key: true
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps
    end
  end
end
