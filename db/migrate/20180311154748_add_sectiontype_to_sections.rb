class AddSectiontypeToSections < ActiveRecord::Migration
  def change
    add_column :sections, :sectiontype, :integer
  end
end
