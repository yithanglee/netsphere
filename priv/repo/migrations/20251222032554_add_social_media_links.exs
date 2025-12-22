defmodule CommerceFront.Repo.Migrations.AddSocialMediaLinks do
  use Ecto.Migration

  def change do
    alter table(:merchants) do
      add :line_id, :string
      add :facebook_url, :string
      add :instagram_id, :string
      add :twitter_url, :string
      add :youtube_url, :string
      add :tiktok_url, :string
      add :pinterest_url, :string
      add :linkedin_url, :string
      add :github_url, :string
      add :whatsapp_number, :string
      add :wechat_number, :string
    end

  end
end
