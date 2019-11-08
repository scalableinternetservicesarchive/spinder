class AddSampleUrl < ActiveRecord::Migration[6.0]
  def change
    add_column :song_infos, :sample_url, :string
  end
end
