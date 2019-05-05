defmodule Mofiin.MediaTest do
  use Mofiin.DataCase

  alias Mofiin.Media

  describe "banners" do
    alias Mofiin.Media.Banner

    @valid_attrs %{image: "some image", title: "some title"}
    @update_attrs %{image: "some updated image", title: "some updated title"}
    @invalid_attrs %{image: nil, title: nil}

    def banner_fixture(attrs \\ %{}) do
      {:ok, banner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Media.create_banner()

      banner
    end

    test "list_banners/0 returns all banners" do
      banner = banner_fixture()
      assert Media.list_banners() == [banner]
    end

    test "get_banner!/1 returns the banner with given id" do
      banner = banner_fixture()
      assert Media.get_banner!(banner.id) == banner
    end

    test "create_banner/1 with valid data creates a banner" do
      assert {:ok, %Banner{} = banner} = Media.create_banner(@valid_attrs)
      assert banner.image == "some image"
      assert banner.title == "some title"
    end

    test "create_banner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_banner(@invalid_attrs)
    end

    test "update_banner/2 with valid data updates the banner" do
      banner = banner_fixture()
      assert {:ok, banner} = Media.update_banner(banner, @update_attrs)
      assert %Banner{} = banner
      assert banner.image == "some updated image"
      assert banner.title == "some updated title"
    end

    test "update_banner/2 with invalid data returns error changeset" do
      banner = banner_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_banner(banner, @invalid_attrs)
      assert banner == Media.get_banner!(banner.id)
    end

    test "delete_banner/1 deletes the banner" do
      banner = banner_fixture()
      assert {:ok, %Banner{}} = Media.delete_banner(banner)
      assert_raise Ecto.NoResultsError, fn -> Media.get_banner!(banner.id) end
    end

    test "change_banner/1 returns a banner changeset" do
      banner = banner_fixture()
      assert %Ecto.Changeset{} = Media.change_banner(banner)
    end
  end
end
