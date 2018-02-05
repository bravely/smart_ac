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

  alias SmartAc.Devices.StatusReport

  @doc """
  Returns the list of status_reports.

  ## Examples

      iex> list_status_reports()
      [%StatusReport{}, ...]

  """
  def list_status_reports do
    Repo.all(StatusReport)
  end

  @doc """
  Gets a single status_report.

  Raises `Ecto.NoResultsError` if the Status report does not exist.

  ## Examples

      iex> get_status_report!(123)
      %StatusReport{}

      iex> get_status_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_status_report!(id), do: Repo.get!(StatusReport, id)

  @doc """
  Creates a status_report.

  ## Examples

      iex> create_status_report(%{field: value})
      {:ok, %StatusReport{}}

      iex> create_status_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_status_report(attrs \\ %{}) do
    %StatusReport{}
    |> StatusReport.changeset(attrs)
    |> Repo.insert()
  end

  def bulk_create_status_reports(%AirConditioner{id: air_conditioner_id}, status_reports) when is_list(status_reports) do
    Repo.transaction(fn ->
      Enum.map(status_reports, fn(attrs) ->
        {:ok, status_report} =
          attrs
          |> Enum.into(%{"air_conditioner_id" => air_conditioner_id})
          |> create_status_report

        status_report
      end)
    end)
  end

  @doc """
  Updates a status_report.

  ## Examples

      iex> update_status_report(status_report, %{field: new_value})
      {:ok, %StatusReport{}}

      iex> update_status_report(status_report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_status_report(%StatusReport{} = status_report, attrs) do
    status_report
    |> StatusReport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a StatusReport.

  ## Examples

      iex> delete_status_report(status_report)
      {:ok, %StatusReport{}}

      iex> delete_status_report(status_report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_status_report(%StatusReport{} = status_report) do
    Repo.delete(status_report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking status_report changes.

  ## Examples

      iex> change_status_report(status_report)
      %Ecto.Changeset{source: %StatusReport{}}

  """
  def change_status_report(%StatusReport{} = status_report) do
    StatusReport.changeset(status_report, %{})
  end
end
