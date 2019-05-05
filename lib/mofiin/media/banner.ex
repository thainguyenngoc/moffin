defmodule Mofiin.Media.Banner do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset

  alias Mofiin.Media.Banner

  schema "banners" do
    field :image, Mofiin.Media.Type
    field :title, :string
    field :path, :string

    timestamps()
  end

  @doc false
  def changeset(%Banner{} = banner, attrs) do
    banner
    |> cast(attrs, [:title, :path])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:image, :title, :path])
  end
end
