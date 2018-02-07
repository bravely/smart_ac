defmodule SmartAc.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SmartAc.Accounts.User


  schema "users" do
    field :email, :string
    field :enabled, :boolean, default: true
    field :password_hash, :string
    field :access_token, :string

    field :password, :string, virtual: true

    timestamps()
  end

  def registration_changeset(user \\ %User{}, attrs) do
    user
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> changeset(attrs)
  end

  @doc false
  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, [:email, :password, :enabled])
    |> validate_required([:email, :enabled])
    |> unsafe_validate_unique([:email], SmartAc.Repo)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> hash_password
  end

  def hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end
  def hash_password(changeset), do: changeset
end
