defmodule SmartAc.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SmartAc.Accounts.User


  schema "users" do
    field :email, :string
    field :enabled, :boolean, default: true
    field :password_hash, :string

    field :password, :string, virtual: true

    timestamps()
  end

  def registration_changeset(attrs) do
    %User{}
    |> cast(attrs, [:email, :password, :enabled])
    |> validate_required([:email, :password, :enabled])
    |> validate_length(:password, min: 8)
    |> hash_password
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :enabled])
    |> validate_required([:email, :enabled])
    |> validate_length(:password, min: 8)
    |> hash_password
  end

  def hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end
  def hash_password(changeset), do: changeset
end
