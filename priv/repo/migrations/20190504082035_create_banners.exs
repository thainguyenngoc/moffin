defmodule Mofiin.Repo.Migrations.CreateBanners do
  use Ecto.Migration

  def change do
    create table(:banners) do
      add :title, :string
      add :image, :string
      add :path, :string

      timestamps()
    end

  end
end
