defmodule SmartAc.Devices do
  @moduledoc """
  The Devices context.
  """

  import Ecto.Query, warn: false
  alias SmartAc.Repo

  alias SmartAc.Devices.AirConditioner

  @doc """
  Returns the list of air_conditioners.

  ## Examples

      iex> list_air_conditioners()
      [%AirConditioner{}, ...]

  """
  def list_air_conditioners do
    Repo.all(AirConditioner)
  end

  @doc """
  Gets a single air_conditioner.

  Raises `Ecto.NoResultsError` if the Air conditioner does not exist.

  ## Examples

      iex> get_air_conditioner!(123)
      %AirConditioner{}

      iex> get_air_conditioner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_air_conditioner!(id), do: Repo.get!(AirConditioner, id)

  def find_air_conditioner_by_serial(serial) do
    Repo.one(from ac in AirConditioner, where: ac.serial == ^serial, limit: 1)
  end

  @doc """
  Creates a air_conditioner.

  ## Examples

      iex> create_air_conditioner(%{field: value})
      {:ok, %AirConditioner{}}

      iex> create_air_conditioner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_air_conditioner(attrs \\ %{}) do
    %AirConditioner{}
    |> AirConditioner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a air_conditioner.

  ## Examples

      iex> update_air_conditioner(air_conditioner, %{field: new_value})
      {:ok, %AirConditioner{}}

      iex> update_air_conditioner(air_conditioner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_air_conditioner(%AirConditioner{} = air_conditioner, attrs) do
    air_conditioner
    |> AirConditioner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AirConditioner.

  ## Examples

      iex> delete_air_conditioner(air_conditioner)
      {:ok, %AirConditioner{}}

      iex> delete_air_conditioner(air_conditioner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_air_conditioner(%AirConditioner{} = air_conditioner) do
    Repo.delete(air_conditioner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking air_conditioner changes.

  ## Examples

      iex> change_air_conditioner(air_conditioner)
      %Ecto.Changeset{source: %AirConditioner{}}

  """
  def change_air_conditioner(%AirConditioner{} = air_conditioner) do
    AirConditioner.changeset(air_conditioner, %{})
  end
end
