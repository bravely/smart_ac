defmodule SmartAc.AccountsTest do
  use SmartAc.DataCase

  alias SmartAc.Accounts

  describe "users" do
    alias SmartAc.Accounts.User

    @valid_attrs %{email: "some email", enabled: true, password: "some password"}
    @update_attrs %{email: "some updated email", enabled: false, password: "some updated password"}
    @invalid_attrs %{email: nil, enabled: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = Repo.get(User, user_fixture().id)
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "find_user_by_email/1 returns the user with the given email" do
      user = user_fixture()
      assert Accounts.find_user_by_email(user.email) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.enabled == true
      assert user.password_hash
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      old_user = user_fixture()
      assert {:ok, user} = Accounts.update_user(old_user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.password_hash != old_user.password_hash
      assert user.enabled == false
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
