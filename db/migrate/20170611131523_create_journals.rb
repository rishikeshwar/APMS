class CreateJournals < ActiveRecord::Migration[5.0]
  def change
    create_table :journals do |t|
      t.integer :user_id
      t.string :Author
      t.string :Title
      t.string :JournalName
      t.string :Scopus
      t.string :ImpactFactor
      t.date :JournalDate
      t.string :ISSNISBN
      t.string :NameOfThePublisher
      t.string :VolumeIssuePageNumber
      t.string :NameBtechMtech
      t.integer :Cost
      t.string :OtherDetails
      t.string :AdminApproval

      t.timestamps
    end
  end
end
